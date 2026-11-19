import argparse
import json
import logging
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

import boto3
from botocore.exceptions import BotoCoreError, ClientError, ProfileNotFound


def setup_logging(log_file: str) -> None:
    Path(log_file).parent.mkdir(parents=True, exist_ok=True)

    logging.basicConfig(
        filename=log_file,
        level=logging.INFO,
        format="%(asctime)s | %(levelname)s | %(message)s",
        encoding="utf-8"
    )

    console = logging.StreamHandler()
    console.setLevel(logging.INFO)
    console.setFormatter(logging.Formatter("%(levelname)s | %(message)s"))
    logging.getLogger("").addHandler(console)


def load_config(config_path: str) -> dict:
    with open(config_path, "r", encoding="utf-8") as file:
        return json.load(file)


def json_serializer(value):
    if isinstance(value, datetime):
        return value.isoformat()
    return str(value)


def create_session(profile_name: str):
    try:
        return boto3.Session(profile_name=profile_name)
    except ProfileNotFound:
        logging.error("Profil AWS introuvable : %s", profile_name)
        raise


def get_backup_client(session, region: str):
    return session.client("backup", region_name=region)


def list_recovery_points(backup_client, vault_name: str) -> list:
    recovery_points = []

    paginator = backup_client.get_paginator("list_recovery_points_by_backup_vault")

    for page in paginator.paginate(BackupVaultName=vault_name):
        recovery_points.extend(page.get("RecoveryPoints", []))

    return recovery_points


def find_latest_ebs_recovery_point(recovery_points: list, resource_arn_filter: str = ""):
    candidates = []

    for point in recovery_points:
        if point.get("ResourceType") != "EBS":
            continue

        if point.get("Status") != "COMPLETED":
            continue

        if resource_arn_filter:
            if point.get("ResourceArn") != resource_arn_filter:
                continue

        candidates.append(point)

    if not candidates:
        return None

    candidates.sort(
        key=lambda item: item.get("CreationDate", datetime.min.replace(tzinfo=timezone.utc)),
        reverse=True
    )

    return candidates[0]


def write_json_report(data: dict, output_dir: str, prefix: str) -> Path:
    Path(output_dir).mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    path = Path(output_dir) / f"{prefix}_{timestamp}.json"

    with open(path, "w", encoding="utf-8") as file:
        json.dump(data, file, indent=2, default=json_serializer, ensure_ascii=False)

    logging.info("Rapport généré : %s", path)
    return path


def ask_confirmation(recovery_point: dict, metadata: dict) -> bool:
    print("\n===== Confirmation restauration EBS =====")
    print(f"RecoveryPointArn : {recovery_point.get('RecoveryPointArn')}")
    print(f"ResourceArn      : {recovery_point.get('ResourceArn')}")
    print(f"CreationDate     : {recovery_point.get('CreationDate')}")
    print(f"Metadata         : {metadata}")
    print("\nCette action va créer un NOUVEAU volume EBS restauré.")
    print("Elle ne doit pas supprimer le volume original.")

    answer = input("\nTape RESTORE pour confirmer la restauration : ").strip()

    return answer == "RESTORE"


def start_restore_job(backup_client, recovery_point_arn: str, iam_role_arn: str, metadata: dict) -> dict:
    response = backup_client.start_restore_job(
        RecoveryPointArn=recovery_point_arn,
        IamRoleArn=iam_role_arn,
        Metadata=metadata,
        IdempotencyToken=f"pfa-ebs-restore-{int(time.time())}"
    )

    return response


def wait_for_restore_job(backup_client, restore_job_id: str, interval: int, max_wait_minutes: int) -> dict:
    max_attempts = max(1, int((max_wait_minutes * 60) / interval))

    for attempt in range(1, max_attempts + 1):
        response = backup_client.describe_restore_job(
            RestoreJobId=restore_job_id
        )

        status = response.get("Status")
        status_message = response.get("StatusMessage", "")

        logging.info(
            "RestoreJobId=%s | tentative=%s/%s | status=%s | message=%s",
            restore_job_id,
            attempt,
            max_attempts,
            status,
            status_message
        )

        print(f"Restore job status : {status}")

        if status in ["COMPLETED", "FAILED", "ABORTED"]:
            return response

        time.sleep(interval)

    return {
        "RestoreJobId": restore_job_id,
        "Status": "TIMEOUT",
        "StatusMessage": f"Timeout après {max_wait_minutes} minutes."
    }


def main():
    parser = argparse.ArgumentParser(
        description="Restauration EBS semi-automatique depuis AWS Backup"
    )

    parser.add_argument(
        "--config",
        default="config/restore_ebs_config.json",
        help="Chemin du fichier de configuration JSON."
    )

    parser.add_argument(
        "--profile",
        default=None,
        help="Profil AWS à utiliser. Remplace celui du fichier config."
    )

    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Mode simulation : prépare la restauration sans la lancer."
    )

    parser.add_argument(
        "--yes",
        action="store_true",
        help="Lance la restauration sans saisie interactive RESTORE."
    )

    args = parser.parse_args()

    config = load_config(args.config)

    setup_logging(config.get("log_file", "logs/ebs_restore_semiauto.log"))

    profile = args.profile or config.get("aws_profile")
    region = config.get("region")
    vault_name = config.get("backup_vault_name")
    iam_role_arn = config.get("iam_role_arn")
    output_dir = config.get("output_dir", "reports/restore")
    interval = int(config.get("poll_interval_seconds", 30))
    max_wait = int(config.get("max_wait_minutes", 30))
    resource_arn_filter = config.get("resource_arn_filter", "")
    metadata = config.get("restore_metadata", {})

    logging.info("Début script restauration EBS")
    logging.info("Profil=%s | Région=%s | Coffre=%s", profile, region, vault_name)

    try:
        session = create_session(profile)
        backup_client = get_backup_client(session, region)

        recovery_points = list_recovery_points(backup_client, vault_name)

        latest_point = find_latest_ebs_recovery_point(
            recovery_points,
            resource_arn_filter
        )

        if latest_point is None:
            message = "Aucun recovery point EBS COMPLETED trouvé."
            logging.error(message)

            report = {
                "status": "NO_RECOVERY_POINT",
                "message": message,
                "vault_name": vault_name,
                "region": region,
                "resource_arn_filter": resource_arn_filter,
                "generated_at": datetime.now(timezone.utc)
            }

            write_json_report(report, output_dir, "ebs_restore_no_point")
            print(message)
            sys.exit(2)

        plan = {
            "status": "PLAN_READY",
            "dry_run": args.dry_run,
            "profile": profile,
            "region": region,
            "backup_vault_name": vault_name,
            "iam_role_arn": iam_role_arn,
            "selected_recovery_point": latest_point,
            "restore_metadata": metadata,
            "generated_at": datetime.now(timezone.utc)
        }

        write_json_report(plan, output_dir, "ebs_restore_plan")

        print("\nDernier recovery point EBS sélectionné :")
        print(f"- RecoveryPointArn : {latest_point.get('RecoveryPointArn')}")
        print(f"- ResourceArn      : {latest_point.get('ResourceArn')}")
        print(f"- CreationDate     : {latest_point.get('CreationDate')}")

        if args.dry_run:
            print("\nMode simulation activé : aucune restauration lancée.")
            logging.info("Dry-run terminé sans restauration.")
            return

        if not args.yes:
            confirmed = ask_confirmation(latest_point, metadata)

            if not confirmed:
                print("Restauration annulée par l’utilisateur.")
                logging.warning("Restauration annulée par l’utilisateur.")
                return

        response = start_restore_job(
            backup_client=backup_client,
            recovery_point_arn=latest_point.get("RecoveryPointArn"),
            iam_role_arn=iam_role_arn,
            metadata=metadata
        )

        restore_job_id = response.get("RestoreJobId")

        logging.info("Restore job lancé : %s", restore_job_id)
        print(f"\nRestore job lancé : {restore_job_id}")

        final_status = wait_for_restore_job(
            backup_client,
            restore_job_id,
            interval,
            max_wait
        )

        report = {
            "status": "RESTORE_JOB_FINISHED",
            "restore_job_id": restore_job_id,
            "final_status": final_status,
            "selected_recovery_point": latest_point,
            "restore_metadata": metadata,
            "generated_at": datetime.now(timezone.utc)
        }

        write_json_report(report, output_dir, "ebs_restore_result")

        print("\n===== Résultat final =====")
        print(json.dumps(final_status, indent=2, default=json_serializer, ensure_ascii=False))

    except ClientError as error:
        logging.error("Erreur AWS ClientError : %s", error)

        report = {
            "status": "AWS_CLIENT_ERROR",
            "error": str(error),
            "generated_at": datetime.now(timezone.utc)
        }

        write_json_report(report, output_dir, "ebs_restore_error")
        print("Erreur AWS :", error)
        sys.exit(1)

    except BotoCoreError as error:
        logging.error("Erreur BotoCore : %s", error)

        report = {
            "status": "BOTOCORE_ERROR",
            "error": str(error),
            "generated_at": datetime.now(timezone.utc)
        }

        write_json_report(report, output_dir, "ebs_restore_error")
        print("Erreur BotoCore :", error)
        sys.exit(1)

    finally:
        logging.info("Fin script restauration EBS")


if __name__ == "__main__":
    main()