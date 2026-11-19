import argparse
import csv
import json
import logging
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
    except ProfileNotFound as error:
        logging.error("Profil AWS introuvable : %s", profile_name)
        raise error


def get_client(session, service: str, region: str):
    return session.client(service, region_name=region)


def paginate(client, operation_name: str, result_key: str, **kwargs) -> list:
    try:
        paginator = client.get_paginator(operation_name)
        results = []

        for page in paginator.paginate(**kwargs):
            results.extend(page.get(result_key, []))

        return results

    except client.exceptions.InvalidParameterValueException as error:
        logging.warning("Paramètre invalide pour %s : %s", operation_name, error)
        return []

    except ClientError as error:
        logging.error("Erreur AWS pour %s : %s", operation_name, error)
        return []

    except BotoCoreError as error:
        logging.error("Erreur BotoCore pour %s : %s", operation_name, error)
        return []


def list_backup_vaults(backup_client) -> list:
    return paginate(
        backup_client,
        "list_backup_vaults",
        "BackupVaultList"
    )


def list_backup_plans(backup_client) -> list:
    return paginate(
        backup_client,
        "list_backup_plans",
        "BackupPlansList"
    )


def list_backup_jobs(backup_client) -> list:
    return paginate(
        backup_client,
        "list_backup_jobs",
        "BackupJobs"
    )


def list_recovery_points(backup_client, vault_name: str) -> list:
    return paginate(
        backup_client,
        "list_recovery_points_by_backup_vault",
        "RecoveryPoints",
        BackupVaultName=vault_name
    )


def summarize_jobs(jobs: list) -> dict:
    summary = {
        "TOTAL": 0,
        "COMPLETED": 0,
        "FAILED": 0,
        "RUNNING": 0,
        "CREATED": 0,
        "EXPIRED": 0,
        "ABORTED": 0,
        "OTHER": 0
    }

    for job in jobs:
        state = job.get("State", "OTHER")
        summary["TOTAL"] += 1

        if state in summary:
            summary[state] += 1
        else:
            summary["OTHER"] += 1

    return summary


def build_inventory(profile: str, regions: list, configured_vaults: list) -> dict:
    session = create_session(profile)

    inventory = {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "profile": profile,
        "regions": {}
    }

    for region in regions:
        logging.info("Inventaire région : %s", region)

        backup_client = get_client(session, "backup", region)

        vaults = list_backup_vaults(backup_client)
        plans = list_backup_plans(backup_client)
        jobs = list_backup_jobs(backup_client)

        vault_names = {vault.get("BackupVaultName") for vault in vaults}

        for configured_vault in configured_vaults:
            if configured_vault not in vault_names:
                logging.warning(
                    "Coffre configuré non trouvé dans %s : %s",
                    region,
                    configured_vault
                )

        recovery_points_by_vault = {}

        for vault in vaults:
            vault_name = vault.get("BackupVaultName")
            recovery_points_by_vault[vault_name] = list_recovery_points(
                backup_client,
                vault_name
            )

        inventory["regions"][region] = {
            "backup_vaults": vaults,
            "backup_plans": plans,
            "backup_jobs": jobs,
            "backup_jobs_summary": summarize_jobs(jobs),
            "recovery_points_by_vault": recovery_points_by_vault
        }

    return inventory


def export_json(inventory: dict, output_dir: str) -> Path:
    Path(output_dir).mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_path = Path(output_dir) / f"aws_backup_inventory_{timestamp}.json"

    with open(output_path, "w", encoding="utf-8") as file:
        json.dump(inventory, file, indent=2, default=json_serializer, ensure_ascii=False)

    logging.info("Rapport JSON généré : %s", output_path)
    return output_path


def export_jobs_csv(inventory: dict, output_dir: str) -> Path:
    Path(output_dir).mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_path = Path(output_dir) / f"aws_backup_jobs_{timestamp}.csv"

    fields = [
        "region",
        "BackupJobId",
        "BackupVaultName",
        "ResourceType",
        "State",
        "CreationDate",
        "CompletionDate",
        "ResourceArn",
        "RecoveryPointArn",
        "StatusMessage"
    ]

    with open(output_path, "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=fields)
        writer.writeheader()

        for region, region_data in inventory["regions"].items():
            for job in region_data.get("backup_jobs", []):
                writer.writerow({
                    "region": region,
                    "BackupJobId": job.get("BackupJobId", ""),
                    "BackupVaultName": job.get("BackupVaultName", ""),
                    "ResourceType": job.get("ResourceType", ""),
                    "State": job.get("State", ""),
                    "CreationDate": json_serializer(job.get("CreationDate", "")),
                    "CompletionDate": json_serializer(job.get("CompletionDate", "")),
                    "ResourceArn": job.get("ResourceArn", ""),
                    "RecoveryPointArn": job.get("RecoveryPointArn", ""),
                    "StatusMessage": job.get("StatusMessage", "")
                })

    logging.info("Rapport CSV jobs généré : %s", output_path)
    return output_path


def export_recovery_points_csv(inventory: dict, output_dir: str) -> Path:
    Path(output_dir).mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_path = Path(output_dir) / f"aws_recovery_points_{timestamp}.csv"

    fields = [
        "region",
        "BackupVaultName",
        "ResourceType",
        "Status",
        "CreationDate",
        "CompletionDate",
        "RecoveryPointArn",
        "ResourceArn",
        "CalculatedLifecycle"
    ]

    with open(output_path, "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=fields)
        writer.writeheader()

        for region, region_data in inventory["regions"].items():
            recovery_by_vault = region_data.get("recovery_points_by_vault", {})

            for vault_name, recovery_points in recovery_by_vault.items():
                for point in recovery_points:
                    writer.writerow({
                        "region": region,
                        "BackupVaultName": vault_name,
                        "ResourceType": point.get("ResourceType", ""),
                        "Status": point.get("Status", ""),
                        "CreationDate": json_serializer(point.get("CreationDate", "")),
                        "CompletionDate": json_serializer(point.get("CompletionDate", "")),
                        "RecoveryPointArn": point.get("RecoveryPointArn", ""),
                        "ResourceArn": point.get("ResourceArn", ""),
                        "CalculatedLifecycle": json.dumps(
                            point.get("CalculatedLifecycle", {}),
                            default=json_serializer
                        )
                    })

    logging.info("Rapport CSV recovery points généré : %s", output_path)
    return output_path


def print_summary(inventory: dict) -> None:
    print("\n===== Résumé AWS Backup Inventory =====")

    for region, data in inventory["regions"].items():
        print(f"\nRégion : {region}")
        print(f"  Coffres Backup : {len(data.get('backup_vaults', []))}")
        print(f"  Plans Backup   : {len(data.get('backup_plans', []))}")

        summary = data.get("backup_jobs_summary", {})
        print(f"  Jobs total     : {summary.get('TOTAL', 0)}")
        print(f"  Jobs réussis   : {summary.get('COMPLETED', 0)}")
        print(f"  Jobs échoués   : {summary.get('FAILED', 0)}")
        print(f"  Jobs en cours  : {summary.get('RUNNING', 0)}")

        total_recovery_points = sum(
            len(points)
            for points in data.get("recovery_points_by_vault", {}).values()
        )
        print(f"  Recovery points: {total_recovery_points}")


def main():
    parser = argparse.ArgumentParser(
        description="Inventaire AWS Backup & DRP avec Boto3"
    )

    parser.add_argument(
        "--config",
        default="config/inventory_config.json",
        help="Chemin du fichier de configuration JSON."
    )

    parser.add_argument(
        "--profile",
        default=None,
        help="Profil AWS à utiliser. Remplace celui du fichier config."
    )

    args = parser.parse_args()

    config = load_config(args.config)

    setup_logging(config.get("log_file", "logs/aws_backup_inventory.log"))

    profile = args.profile or config.get("aws_profile")
    regions = config.get("regions", ["eu-west-3"])
    output_dir = config.get("output_dir", "reports/inventory")
    configured_vaults = config.get("backup_vaults", [])

    logging.info("Début inventaire AWS Backup")
    logging.info("Profil utilisé : %s", profile)

    try:
      inventory = build_inventory(profile, regions, configured_vaults)
    except ProfileNotFound:
      print(f"ERREUR : le profil AWS '{profile}' est introuvable sur ce PC.")
      print("Vérifie les profils disponibles avec : aws configure list-profiles")
      logging.error("Arrêt du script : profil AWS introuvable.")
      return

    json_path = export_json(inventory, output_dir)
    jobs_csv_path = export_jobs_csv(inventory, output_dir)
    recovery_csv_path = export_recovery_points_csv(inventory, output_dir)

    print_summary(inventory)

    print("\nRapports générés :")
    print(f"- JSON : {json_path}")
    print(f"- CSV jobs : {jobs_csv_path}")
    print(f"- CSV recovery points : {recovery_csv_path}")

    logging.info("Fin inventaire AWS Backup")


if __name__ == "__main__":
    main()