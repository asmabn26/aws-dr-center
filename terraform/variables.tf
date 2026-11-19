variable "aws_region" {
  description = "Région AWS réellement accessible avec le Free account plan."
  type        = string
}

variable "aws_profile" {
  description = "Profil AWS CLI utilisé pour exécuter Terraform."
  type        = string
}

variable "project_name" {
  description = "Nom du projet."
  type        = string
  default     = "pfa-drp-aws"
}

variable "environment" {
  description = "Environnement du laboratoire."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "dr"], var.environment)
    error_message = "La valeur doit être dev, test ou dr."
  }
}

variable "owner" {
  description = "Responsable du projet."
  type        = string
  default     = "asma-ikram"
}

variable "expiration_date" {
  description = "Date prévue de suppression des ressources temporaires."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR principal du VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "CIDR du sous-réseau public A."
  type        = string
  default     = "10.10.1.0/24"
}

variable "private_subnet_a_cidr" {
  description = "CIDR du sous-réseau privé A."
  type        = string
  default     = "10.10.10.0/24"
}

variable "private_subnet_b_cidr" {
  description = "CIDR du sous-réseau privé B."
  type        = string
  default     = "10.10.20.0/24"
}

variable "database_port" {
  description = "Port de la future base de données RDS. 3306 pour MySQL, 5432 pour PostgreSQL."
  type        = number
  default     = 3306
}

variable "admin_cidr" {
  description = "Adresse IP publique autorisée à se connecter en SSH, au format YOUR_PUBLIC_IP/32."
  type        = string
}

variable "ssh_public_key_path" {
  description = "Chemin local vers la clé publique SSH."
  type        = string
}

variable "ec2_instance_type" {
  description = "Type de l’instance EC2 du laboratoire."
  type        = string
  default     = "t3.micro"
}

variable "ebs_volume_size" {
  description = "Taille du volume EBS de données en GiB."
  type        = number
  default     = 1
}

variable "ebs_volume_type" {
  description = "Type du volume EBS."
  type        = string
  default     = "gp3"
}

variable "ebs_device_name" {
  description = "Nom du device utilisé pour attacher le volume à l'instance EC2."
  type        = string
  default     = "/dev/sdf"
}

variable "db_engine" {
  description = "Moteur de base de données RDS."
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Version du moteur MySQL."
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "Classe de l'instance RDS."
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Taille du stockage RDS en GiB."
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Nom de la base de données témoin."
  type        = string
  default     = "pfadrpdb"
}

variable "db_username" {
  description = "Nom d'utilisateur administrateur RDS."
  type        = string
  default     = "adminuser"
}

variable "db_password" {
  description = "Mot de passe administrateur RDS."
  type        = string
  sensitive   = true
}

variable "backup_vault_name" {
  description = "Nom du coffre AWS Backup principal."
  type        = string
  default     = "primary"
}

variable "backup_kms_deletion_window" {
  description = "Nombre de jours avant suppression définitive de la clé KMS."
  type        = number
  default     = 7
}

variable "backup_daily_retention_days" {
  description = "Durée de rétention des sauvegardes quotidiennes en jours."
  type        = number
  default     = 7
}

variable "backup_weekly_retention_days" {
  description = "Durée de rétention des sauvegardes hebdomadaires en jours."
  type        = number
  default     = 30
}

variable "backup_daily_schedule" {
  description = "Planification quotidienne AWS Backup en UTC."
  type        = string
  default     = "cron(0 1 * * ? *)"
}

variable "backup_weekly_schedule" {
  description = "Planification hebdomadaire AWS Backup en UTC."
  type        = string
  default     = "cron(0 2 ? * SUN *)"
}

variable "backup_start_window_minutes" {
  description = "Fenêtre de démarrage du backup job en minutes."
  type        = number
  default     = 60
}

variable "backup_completion_window_minutes" {
  description = "Fenêtre maximale d'exécution du backup job en minutes."
  type        = number
  default     = 180
}

variable "backup_selection_tag_key" {
  description = "Tag utilisé pour sélectionner les ressources à sauvegarder."
  type        = string
  default     = "backup"
}

variable "backup_selection_tag_value" {
  description = "Valeur du tag utilisé pour sélectionner les ressources à sauvegarder."
  type        = string
  default     = "daily"
}

variable "dr_region" {
  description = "Région AWS secondaire utilisée pour la reprise après sinistre."
  type        = string
  default     = "eu-north-1"
}

variable "dr_backup_vault_name" {
  description = "Nom du coffre AWS Backup secondaire."
  type        = string
  default     = "dr"
}

variable "dr_backup_copy_retention_days" {
  description = "Durée de rétention des copies interrégionales en jours."
  type        = number
  default     = 7
}

variable "dr_kms_deletion_window" {
  description = "Nombre de jours avant suppression définitive de la clé KMS DR."
  type        = number
  default     = 7
}


variable "backup_vault_lock_min_retention_days" {
  description = "Durée minimale de conservation des recovery points dans le coffre."
  type        = number
  default     = 7
}

variable "backup_vault_lock_max_retention_days" {
  description = "Durée maximale de conservation des recovery points dans le coffre."
  type        = number
  default     = 30
}

variable "enable_backup_vault_lock" {
  description = "Activer le verrouillage du coffre AWS Backup en mode gouvernance pour le laboratoire."
  type        = bool
  default     = true
}

# =========================================================
# J17 — IAM ACCESS MATRIX VARIABLES
# =========================================================

variable "iam_readonly_user_name" {
  description = "Utilisateur IAM utilisé pour les tests en lecture seule."
  type        = string
  default     = "ikram-pfa"
}

variable "iam_backup_operator_name" {
  description = "Nom de la politique IAM opérateur sauvegarde."
  type        = string
  default     = "backup-operator"
}

variable "iam_restore_operator_name" {
  description = "Nom de la politique IAM opérateur restauration."
  type        = string
  default     = "restore-operator"
}

variable "iam_readonly_operator_name" {
  description = "Nom de la politique IAM lecture seule."
  type        = string
  default     = "readonly-auditor"
}
# =========================================================
# J19 — MONITORING AND NOTIFICATIONS VARIABLES
# =========================================================

variable "notification_email_asma" {
  description = "Adresse e-mail Asma pour recevoir les notifications SNS."
  type        = string
  default     = "asma@example.com"
}

variable "notification_email_ikram" {
  description = "Adresse e-mail Ikram pour recevoir les notifications SNS."
  type        = string
  default     = "ikram@example.com"
}

variable "cloudwatch_dashboard_name" {
  description = "Nom du dashboard CloudWatch du projet."
  type        = string
  default     = "pfa-drp-aws-dashboard"
}

# =========================================================
# J20 — CLOUDTRAIL AUDIT VARIABLES
# =========================================================

variable "cloudtrail_name" {
  description = "Nom du trail CloudTrail principal."
  type        = string
  default     = "audit"
}

variable "cloudtrail_log_retention_days" {
  description = "Durée de conservation des logs CloudTrail dans S3."
  type        = number
  default     = 30
}
