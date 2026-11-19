output "aws_region" {
  description = "Région AWS utilisée."
  value       = var.aws_region
}

output "project_name" {
  description = "Nom du projet."
  value       = var.project_name
}

output "environment" {
  description = "Environnement."
  value       = var.environment
}

output "vpc_id" {
  description = "ID du VPC principal."
  value       = aws_vpc.main.id
}

output "public_subnet_a_id" {
  description = "ID du sous-réseau public A."
  value       = aws_subnet.public_a.id
}

output "private_subnet_a_id" {
  description = "ID du sous-réseau privé A."
  value       = aws_subnet.private_a.id
}

output "private_subnet_b_id" {
  description = "ID du sous-réseau privé B."
  value       = aws_subnet.private_b.id
}

output "internet_gateway_id" {
  description = "ID de l’Internet Gateway."
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "ID de la table de routage publique."
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID de la table de routage privée."
  value       = aws_route_table.private.id
}

output "ec2_security_group_id" {
  description = "ID du Security Group EC2."
  value       = aws_security_group.ec2_app.id
}

output "rds_security_group_id" {
  description = "ID du Security Group RDS."
  value       = aws_security_group.rds_db.id
}

output "ec2_instance_id" {
  description = "ID de l’instance EC2."
  value       = aws_instance.app.id
}

output "ec2_public_ip" {
  description = "Adresse IPv4 publique de l’instance EC2."
  value       = aws_instance.app.public_ip
}

output "ec2_private_ip" {
  description = "Adresse IPv4 privée de l’instance EC2."
  value       = aws_instance.app.private_ip
}

output "ec2_ssh_command" {
  description = "Commande SSH pour se connecter à l’instance."
  value       = "ssh -i ${replace(var.ssh_public_key_path, ".pub", "")} ec2-user@${aws_instance.app.public_ip}"
}

output "ebs_volume_id" {
  description = "ID du volume EBS de données."
  value       = aws_ebs_volume.data.id
}

output "ebs_volume_az" {
  description = "Zone de disponibilité du volume EBS."
  value       = aws_ebs_volume.data.availability_zone
}

output "ebs_device_name" {
  description = "Nom du device configuré pour l'attachement EBS."
  value       = var.ebs_device_name
}

output "s3_bucket_name" {
  description = "Nom du bucket S3 DRP."
  value       = aws_s3_bucket.drp_data.bucket
}

output "s3_bucket_arn" {
  description = "ARN du bucket S3 DRP."
  value       = aws_s3_bucket.drp_data.arn
}

output "rds_endpoint" {
  description = "Endpoint de la base RDS."
  value       = aws_db_instance.main.address
}

output "rds_port" {
  description = "Port de la base RDS."
  value       = aws_db_instance.main.port
}

output "rds_identifier" {
  description = "Identifiant de l'instance RDS."
  value       = aws_db_instance.main.identifier
}

output "rds_database_name" {
  description = "Nom de la base de données RDS."
  value       = aws_db_instance.main.db_name
}

output "backup_vault_name" {
  description = "Nom du coffre AWS Backup principal."
  value       = aws_backup_vault.primary.name
}

output "backup_vault_arn" {
  description = "ARN du coffre AWS Backup principal."
  value       = aws_backup_vault.primary.arn
}

output "backup_kms_key_id" {
  description = "ID de la clé KMS utilisée pour AWS Backup."
  value       = aws_kms_key.backup.key_id
}

output "backup_kms_key_arn" {
  description = "ARN de la clé KMS utilisée pour AWS Backup."
  value       = aws_kms_key.backup.arn
}

output "aws_backup_role_arn" {
  description = "ARN du rôle IAM utilisé par AWS Backup."
  value       = aws_iam_role.aws_backup.arn
}

output "backup_limited_policy_arn" {
  description = "ARN de la politique IAM limitée pour les tests."
  value       = aws_iam_policy.backup_vault_limited_access.arn
}

output "backup_plan_id" {
  description = "ID du plan AWS Backup principal."
  value       = aws_backup_plan.main.id
}

output "backup_plan_arn" {
  description = "ARN du plan AWS Backup principal."
  value       = aws_backup_plan.main.arn
}

output "backup_selection_id" {
  description = "ID de la sélection de ressources par tags."
  value       = aws_backup_selection.tagged_resources.id
}

output "backup_selection_tag" {
  description = "Tag utilisé pour sélectionner les ressources sauvegardées."
  value       = "${var.backup_selection_tag_key}=${var.backup_selection_tag_value}"
}

output "dr_region" {
  description = "Région secondaire DR."
  value       = var.dr_region
}

output "dr_backup_vault_name" {
  description = "Nom du coffre AWS Backup DR."
  value       = aws_backup_vault.dr.name
}

output "dr_backup_vault_arn" {
  description = "ARN du coffre AWS Backup DR."
  value       = aws_backup_vault.dr.arn
}

output "dr_kms_key_arn" {
  description = "ARN de la clé KMS DR."
  value       = aws_kms_key.backup_dr.arn
}

output "backup_vault_lock_enabled" {
  description = "Indique si le verrouillage du coffre est activé."
  value       = var.enable_backup_vault_lock
}

output "backup_vault_lock_min_retention_days" {
  description = "Durée minimale de rétention configurée sur le coffre."
  value       = var.backup_vault_lock_min_retention_days
}


output "backup_vault_lock_max_retention_days" {
  description = "Durée maximale de rétention configurée sur le coffre."
  value       = var.backup_vault_lock_max_retention_days
}

output "iam_backup_operator_policy_arn" {
  description = "ARN de la politique IAM opérateur sauvegarde."
  value       = aws_iam_policy.backup_operator.arn
}

output "iam_restore_operator_policy_arn" {
  description = "ARN de la politique IAM opérateur restauration."
  value       = aws_iam_policy.restore_operator.arn
}

output "iam_readonly_auditor_policy_arn" {
  description = "ARN de la politique IAM lecture seule."
  value       = aws_iam_policy.readonly_auditor.arn
}
# =========================================================
# J19 — MONITORING OUTPUTS
# =========================================================

output "cloudwatch_dashboard_name" {
  description = "Nom du dashboard CloudWatch."
  value       = aws_cloudwatch_dashboard.backup_drp.dashboard_name
}


# =========================================================
# J19 — SNS AND EVENTBRIDGE OUTPUTS
# =========================================================
output "sns_backup_alerts_topic_arn" {
  description = "ARN du topic SNS des alertes AWS Backup."
  value       = aws_sns_topic.backup_alerts.arn
}

output "eventbridge_backup_failed_rule" {
  description = "Nom de la règle EventBridge pour les échecs backup."
  value       = aws_cloudwatch_event_rule.backup_job_failed.name
}

output "eventbridge_backup_completed_rule" {
  description = "Nom de la règle EventBridge pour les succès backup."
  value       = aws_cloudwatch_event_rule.backup_job_completed.name
}

# =========================================================
# J20 — CLOUDTRAIL OUTPUTS
# =========================================================

output "cloudtrail_name" {
  description = "Nom du trail CloudTrail."
  value       = aws_cloudtrail.audit.name
}

output "cloudtrail_s3_bucket_name" {
  description = "Bucket S3 contenant les logs CloudTrail."
  value       = aws_s3_bucket.cloudtrail_logs.bucket
}

output "cloudtrail_s3_bucket_arn" {
  description = "ARN du bucket CloudTrail."
  value       = aws_s3_bucket.cloudtrail_logs.arn
}
