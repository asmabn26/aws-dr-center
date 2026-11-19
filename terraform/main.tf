data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

# =========================================================
# NETWORK — VPC, Subnets, Route Tables
# =========================================================

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-vpc-main"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-igw-main"
    backup      = "none"
    criticality = "medium"
  })
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-subnet-public-a"
    subnet-type = "public"
    backup      = "none"
    criticality = "medium"
  })
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_a_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-subnet-private-a"
    subnet-type = "private"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_b_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-subnet-private-b"
    subnet-type = "private"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-rt-public"
    backup      = "none"
    criticality = "medium"
  })
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-rt-private"
    backup      = "none"
    criticality = "medium"
  })
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

# =========================================================
# SECURITY GROUPS
# =========================================================

resource "aws_security_group" "ec2_app" {
  name        = "${local.name_prefix}-sg-ec2-app"
  description = "Security group for the future EC2 application server"
  vpc_id      = aws_vpc.main.id

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-sg-ec2-app"
    backup      = "none"
    criticality = "medium"
  })
}

resource "aws_security_group" "rds_db" {
  name        = "${local.name_prefix}-sg-rds-db"
  description = "Security group for the future RDS database"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow database traffic only from EC2 security group"
    from_port       = var.database_port
    to_port         = var.database_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_app.id]
  }

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-sg-rds-db"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ssh_admin" {
  security_group_id = aws_security_group.ec2_app.id

  description = "Allow SSH only from admin public IP"
  cidr_ipv4   = var.admin_cidr
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-allow-ssh-admin"
    backup      = "none"
    criticality = "high"
  })
}

# =========================================================
# EC2 APPLICATION SERVER
# =========================================================

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "${local.name_prefix}-ec2-key"
  public_key = file(var.ssh_public_key_path)

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-ec2-key"
    backup      = "none"
    criticality = "medium"
  })
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.ec2_app.id]
  key_name                    = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              mkdir -p /opt/pfa-demo
              cat > /opt/pfa-demo/index.html <<HTML
              <html>
                <head>
                  <title>PFA AWS DRP</title>
                </head>
                <body>
                  <h1>PFA AWS Backup & DRP</h1>
                  <p>Instance EC2 de demonstration fonctionnelle.</p>
                </body>
              </html>
              HTML

              cat > /etc/systemd/system/pfa-demo.service <<SERVICE
              [Unit]
              Description=PFA Demo HTTP Service
              After=network.target

              [Service]
              WorkingDirectory=/opt/pfa-demo
              ExecStart=/usr/bin/python3 -m http.server 8080
              Restart=always

              [Install]
              WantedBy=multi-user.target
              SERVICE

              systemctl daemon-reload
              systemctl enable pfa-demo.service
              systemctl start pfa-demo.service
              EOF

  lifecycle {
    ignore_changes = [
      ami
    ]
  }

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-ec2-app"
    backup      = "daily"
    criticality = "high"
  })
}

# =========================================================
# EBS DATA VOLUME
# =========================================================

resource "aws_ebs_volume" "data" {
  availability_zone = aws_subnet.public_a.availability_zone
  size              = var.ebs_volume_size
  type              = var.ebs_volume_type
  encrypted         = true

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-ebs-data"
    backup      = "daily"
    criticality = "high"
  })
}

resource "aws_volume_attachment" "data" {
  device_name = var.ebs_device_name
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.app.id
}

# =========================================================
# S3 DRP DATA BUCKET
# =========================================================

resource "aws_s3_bucket" "drp_data" {
  bucket = "${var.project_name}-${var.environment}-${data.aws_caller_identity.current.account_id}-drp-data"

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-s3-drp-data"
    backup      = "daily"
    criticality = "high"
  })
}

resource "aws_s3_bucket_public_access_block" "drp_data" {
  bucket = aws_s3_bucket.drp_data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "drp_data" {
  bucket = aws_s3_bucket.drp_data.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "drp_data" {
  bucket = aws_s3_bucket.drp_data.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "drp_data" {
  bucket = aws_s3_bucket.drp_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "drp_data" {
  bucket = aws_s3_bucket.drp_data.id

  rule {
    id     = "manage-noncurrent-versions"
    status = "Enabled"

    filter {
      prefix = ""
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.drp_data
  ]
}

# =========================================================
# RDS DATABASE
# =========================================================

resource "aws_db_subnet_group" "rds" {
  name = "${local.name_prefix}-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-db-subnet-group"
    backup      = "daily"
    criticality = "high"
  })
}

resource "aws_db_instance" "main" {
  identifier = "${local.name_prefix}-rds-main"

  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class

  allocated_storage = var.db_allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds_db.id]

  publicly_accessible = false
  multi_az            = false

  backup_retention_period = 1
  deletion_protection     = false
  skip_final_snapshot     = true

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-rds-main"
    backup      = "daily"
    criticality = "high"
  })
}

resource "aws_iam_role" "aws_backup" {
  name = "${local.name_prefix}-aws-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-aws-backup-role"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_iam_role_policy_attachment" "aws_backup_service_role_backup" {
  role       = aws_iam_role.aws_backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role_policy_attachment" "aws_backup_service_role_restore" {
  role       = aws_iam_role.aws_backup.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

resource "aws_iam_role_policy_attachment" "aws_backup_s3_backup" {
  role       = aws_iam_role.aws_backup.name
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Backup"
}

resource "aws_iam_role_policy_attachment" "aws_backup_s3_restore" {
  role       = aws_iam_role.aws_backup.name
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Restore"
}

data "aws_iam_policy_document" "backup_kms_key_policy" {
  statement {
    sid    = "AllowAccountAdministration"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = [
      "kms:*"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowAWSBackupRoleUsage"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.aws_backup.arn]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = ["*"]
  }
}

resource "aws_kms_key" "backup" {
  description             = "KMS key for AWS Backup vault encryption"
  deletion_window_in_days = var.backup_kms_deletion_window
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.backup_kms_key_policy.json

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-kms-backup"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_kms_alias" "backup" {
  name          = "alias/${local.name_prefix}-backup"
  target_key_id = aws_kms_key.backup.key_id
}

resource "aws_backup_vault" "primary" {
  name        = "${local.name_prefix}-backup-vault-${var.backup_vault_name}"
  kms_key_arn = aws_kms_key.backup.arn

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-backup-vault-${var.backup_vault_name}"
    backup      = "none"
    criticality = "critical"
  })
}

resource "aws_iam_policy" "backup_vault_limited_access" {
  name        = "${local.name_prefix}-backup-vault-limited-access"
  description = "Limited access policy for AWS Backup vault validation"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadBackupVault"
        Effect = "Allow"
        Action = [
          "backup:DescribeBackupVault",
          "backup:ListBackupVaults",
          "backup:ListRecoveryPointsByBackupVault",
          "backup:DescribeRecoveryPoint",
          "kms:DescribeKey"
        ]
        Resource = "*"
      },
      {
        Sid    = "StartBackupJob"
        Effect = "Allow"
        Action = [
          "backup:StartBackupJob",
          "backup:DescribeBackupJob"
        ]
        Resource = "*"
      },
      {
        Sid    = "PassAWSBackupRole"
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = aws_iam_role.aws_backup.arn
        Condition = {
          StringEquals = {
            "iam:PassedToService" = "backup.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-backup-vault-limited-access"
    backup      = "none"
    criticality = "medium"
  })
}


data "aws_iam_policy_document" "backup_dr_kms_key_policy" {
  statement {
    sid    = "AllowAccountAdministration"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = [
      "kms:*"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowAWSBackupRoleUsage"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.aws_backup.arn]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = ["*"]
  }
}

resource "aws_kms_key" "backup_dr" {
  provider = aws.dr

  description             = "KMS key for AWS Backup DR vault encryption"
  deletion_window_in_days = var.dr_kms_deletion_window
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.backup_dr_kms_key_policy.json

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-kms-backup-dr"
    backup      = "none"
    criticality = "critical"
  })
}

resource "aws_kms_alias" "backup_dr" {
  provider = aws.dr

  name          = "alias/${local.name_prefix}-backup-dr"
  target_key_id = aws_kms_key.backup_dr.key_id
}

resource "aws_backup_vault" "dr" {
  provider = aws.dr

  name        = "${local.name_prefix}-backup-vault-${var.dr_backup_vault_name}"
  kms_key_arn = aws_kms_key.backup_dr.arn

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-backup-vault-${var.dr_backup_vault_name}"
    backup      = "none"
    criticality = "critical"
  })
}

resource "aws_backup_plan" "main" {
  name = "${local.name_prefix}-backup-plan-main"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.primary.name
    schedule          = var.backup_daily_schedule

    start_window      = var.backup_start_window_minutes
    completion_window = var.backup_completion_window_minutes

    lifecycle {
      delete_after = var.backup_daily_retention_days
    }

    copy_action {
      destination_vault_arn = aws_backup_vault.dr.arn

      lifecycle {
        delete_after = var.dr_backup_copy_retention_days
      }
    }
  }

  rule {
    rule_name         = "weekly-backup"
    target_vault_name = aws_backup_vault.primary.name
    schedule          = var.backup_weekly_schedule

    start_window      = var.backup_start_window_minutes
    completion_window = var.backup_completion_window_minutes

    lifecycle {
      delete_after = var.backup_weekly_retention_days
    }
  }

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-backup-plan-main"
    backup      = "none"
    criticality = "critical"
  })
}

resource "aws_backup_selection" "tagged_resources" {
  name         = "${local.name_prefix}-backup-selection-tagged"
  plan_id      = aws_backup_plan.main.id
  iam_role_arn = aws_iam_role.aws_backup.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = var.backup_selection_tag_key
    value = var.backup_selection_tag_value
  }
}
resource "aws_iam_user_policy_attachment" "ikram_readonly_auditor" {
  user       = var.iam_readonly_user_name
  policy_arn = aws_iam_policy.readonly_auditor.arn
}

# =========================================================
# J18 — AWS BACKUP VAULT LOCK GOVERNANCE MODE
# =========================================================

resource "aws_iam_policy" "backup_operator" {
  name        = "${local.name_prefix}-${var.iam_backup_operator_name}"
  description = "Policy for starting and monitoring backup jobs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "BackupVaultRead"
        Effect = "Allow"
        Action = [
          "backup:DescribeBackupVault",
          "backup:ListBackupVaults",
          "backup:ListRecoveryPointsByBackupVault",
          "backup:DescribeRecoveryPoint",
          "backup:ListBackupJobs",
          "backup:DescribeBackupJob",
          "backup:GetBackupPlan",
          "backup:ListBackupPlans",
          "backup:ListBackupSelections"
        ]
        Resource = "*"
      },
      {
        Sid      = "StartBackupJob"
        Effect   = "Allow"
        Action   = ["backup:StartBackupJob"]
        Resource = "*"
      },
      {
        Sid      = "PassBackupServiceRole"
        Effect   = "Allow"
        Action   = ["iam:PassRole"]
        Resource = aws_iam_role.aws_backup.arn
        Condition = {
          StringEquals = {
            "iam:PassedToService" = "backup.amazonaws.com"
          }
        }
      },
      {
        Sid    = "ReadProtectedResources"
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeVolumes",
          "rds:DescribeDBInstances",
          "s3:GetBucketTagging",
          "s3:GetBucketVersioning",
          "s3:ListBucket",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-${var.iam_backup_operator_name}"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_iam_policy" "restore_operator" {
  name        = "${local.name_prefix}-${var.iam_restore_operator_name}"
  description = "Policy for starting and monitoring restore jobs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "RestoreRead"
        Effect = "Allow"
        Action = [
          "backup:DescribeBackupVault",
          "backup:ListBackupVaults",
          "backup:ListRecoveryPointsByBackupVault",
          "backup:DescribeRecoveryPoint",
          "backup:StartRestoreJob",
          "backup:DescribeRestoreJob",
          "backup:ListRestoreJobs",
          "kms:DescribeKey"
        ]
        Resource = "*"
      },
      {
        Sid      = "PassBackupServiceRole"
        Effect   = "Allow"
        Action   = ["iam:PassRole"]
        Resource = aws_iam_role.aws_backup.arn
        Condition = {
          StringEquals = {
            "iam:PassedToService" = "backup.amazonaws.com"
          }
        }
      },
      {
        Sid    = "ReadAndAttachRestoredVolumes"
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeVolumes",
          "ec2:AttachVolume",
          "ec2:DetachVolume"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-${var.iam_restore_operator_name}"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_iam_policy" "readonly_auditor" {
  name        = "${local.name_prefix}-${var.iam_readonly_operator_name}"
  description = "Read-only policy for audit and validation"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "BackupReadOnly"
        Effect = "Allow"
        Action = [
          "backup:DescribeBackupVault",
          "backup:ListBackupVaults",
          "backup:ListRecoveryPointsByBackupVault",
          "backup:DescribeRecoveryPoint",
          "backup:ListBackupJobs",
          "backup:DescribeBackupJob",
          "backup:GetBackupPlan",
          "backup:ListBackupPlans",
          "backup:ListBackupSelections",
          "backup:DescribeRestoreJob",
          "backup:ListRestoreJobs"
        ]
        Resource = "*"
      },
      {
        Sid    = "InfrastructureReadOnly"
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeVolumes",
          "ec2:DescribeSnapshots",
          "ec2:DescribeSecurityGroups",
          "rds:DescribeDBInstances",
          "s3:ListAllMyBuckets",
          "s3:GetBucketTagging",
          "s3:GetBucketVersioning",
          "s3:GetBucketEncryption",
          "s3:GetBucketPublicAccessBlock",
          "kms:DescribeKey",
          "iam:GetRole",
          "iam:ListAttachedRolePolicies"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-${var.iam_readonly_operator_name}"
    backup      = "none"
    criticality = "medium"
  })
}

# =========================================================
# J18 — AWS BACKUP VAULT LOCK GOVERNANCE MODE
# =========================================================

resource "aws_backup_vault_lock_configuration" "primary" {
  count = var.enable_backup_vault_lock ? 1 : 0

  backup_vault_name  = aws_backup_vault.primary.name
  min_retention_days = var.backup_vault_lock_min_retention_days
  max_retention_days = var.backup_vault_lock_max_retention_days
}
