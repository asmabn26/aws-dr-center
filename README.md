# AWS DR Center — Backup & Disaster Recovery on AWS

**Cloud resilience | Infrastructure as Code | Backup automation | Disaster recovery**

## Overview

This repository contains the infrastructure configuration, Python automation scripts, and technical documentation developed for an academic final-year project on **backup and disaster recovery using Amazon Web Services (AWS)**.

The project explores a **Backup and Restore** strategy for EC2, EBS, S3, and RDS, with a primary AWS region (`eu-west-3`) and a disaster recovery region (`eu-north-1`). It focuses on backup governance, recovery-point inventory, controlled EBS restoration, monitoring, auditability, and cost awareness.

The accompanying academic report describes the broader **AWS DR Center — Resilience & Recovery** web platform (FastAPI/Boto3 and web interface). **This public repository contains the Terraform and Boto3 portions, not the full FastAPI web application.**

## Key Features

- **Terraform infrastructure:** AWS provider configuration, networking and infrastructure resources, monitoring and audit configuration.
- **AWS Backup:** backup vaults, recovery plans and cross-region recovery strategy documented in the project.
- **Backup inventory:** Boto3 script to list vaults, plans, backup jobs and recovery points; export JSON and CSV reports.
- **EBS recovery:** semi-automated script with recovery-point selection, dry-run option, confirmation and report output.
- **Security and governance:** IAM permissions, KMS considerations, network segmentation, CloudTrail audit and backup-vault protections.
- **Monitoring:** CloudWatch, EventBridge and SNS configuration artifacts.
- **Validation documentation:** restoration procedures, data integrity checks, RTO/RPO considerations and cleanup controls.

## Technologies

| Area | Tools / Services |
|---|---|
| Cloud | AWS EC2, EBS, S3, RDS, AWS Backup |
| Security | IAM, KMS, VPC, CloudTrail |
| Monitoring | CloudWatch, EventBridge, SNS |
| Infrastructure as Code | Terraform |
| Automation | Python, Boto3, Botocore, AWS CLI |
| Reports | JSON, CSV, Markdown |

## Architecture

```text
Infrastructure as Code (Terraform)
              |
              v
       AWS primary region (eu-west-3)
        EC2 / EBS / S3 / RDS
              |
              v
        AWS Backup vault
              |
     Cross-region backup copy
              v
       AWS DR region (eu-north-1)

Python + Boto3 ---> Inventory / EBS recovery workflows
CloudWatch + EventBridge + SNS ---> Monitoring and alerts
CloudTrail ---> Audit evidence
```

## Repository Structure

```text
aws-dr-center/
├── architecture/          # Architecture diagram
├── config/                # Sanitized example configuration
├── documentation/         # Design, recovery and security notes
├── scripts/
│   ├── diagnostic/        # AWS identity check
│   ├── inventory/         # AWS Backup inventory and exports
│   └── restore/           # Semi-automated EBS recovery
├── terraform/             # Infrastructure as Code
├── requirements.txt       # Python dependencies
├── .gitignore
└── README.md
```

## Prerequisites

- Python 3 and pip
- Terraform CLI
- AWS CLI with an **authorized** named profile
- An AWS account with the required permissions
- Awareness that provisioning and restoring AWS resources can **incur charges**

## Local Setup

### 1. Clone

```bash
git clone https://github.com/YOUR_USERNAME/aws-dr-center.git
cd aws-dr-center
```

### 2. Install Python dependencies

```bash
python -m venv .venv
# Windows CMD: .venv\Scripts\activate
# PowerShell: .\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

### 3. Configure AWS CLI

```bash
aws configure --profile your-aws-profile
aws sts get-caller-identity --profile your-aws-profile
```

Use your own credentials and do not commit them. Update `config/inventory_config.json` to match your profile, regions and backup vaults.

### 4. Inspect the Terraform plan (do not apply blindly)

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your own values, IP allowlist, SSH key and notification emails.
terraform init
terraform fmt -check
terraform validate
terraform plan -var-file=terraform.tfvars
```

On Windows CMD, use `copy terraform.tfvars.example terraform.tfvars` instead of `cp`.

**Important:** Terraform was not applied or validated as part of preparing this public archive. Review the planned resources, security rules, cost and deletion behavior before `terraform apply`.

### 5. Run AWS Backup inventory

From the repository root:

```bash
python scripts/inventory/aws_backup_inventory.py --config config/inventory_config.json --profile your-aws-profile
```

The script generates reports under `reports/inventory/`, which is excluded from Git.

### 6. Prepare an EBS restoration dry-run

```bash
# Windows CMD:
copy config\restore_ebs_config.example.json config\restore_ebs_config.json
# Edit the copied file with your own vault, IAM role and region.
python scripts/restore/ebs_restore_semiauto.py --config config/restore_ebs_config.json --profile your-aws-profile --dry-run
```

The configuration must be completed with valid AWS values. **Do not use `--yes` or run a real restoration without reviewing the script, AWS permissions, selected recovery point and expected costs.** A dry-run does not replace testing in an isolated AWS environment.

## Disaster Recovery Workflow

1. Identify protected AWS resources and available recovery points.
2. Prepare the restoration target and validate prerequisites.
3. Perform a dry-run and review expected effects.
4. Confirm the intended operation.
5. Execute restoration in an authorized environment.
6. Validate resource health and data integrity.
7. Record evidence and clean up temporary resources safely.

## Security and Publication Notes

- Never publish AWS credentials, account identifiers, private IP-sensitive operational details, `.tfstate`, or real `terraform.tfvars`.
- Keep IAM permissions scoped to the minimum required actions.
- Restrict SSH access to an authorized IP address.
- Review KMS permissions and backup retention policies before use.
- Avoid public exposure of backup inventory, CloudTrail exports and restoration logs.
- Do not delete recovery points or production resources as part of a test cleanup.

**Public repository cleanup:** Real inventory exports, AWS account identifiers, CloudTrail event dumps, local logs, screenshots and personal spreadsheets have been excluded or sanitized from this release. Original operational evidence should be retained privately.

## Limitations

- The FastAPI dashboard described in the academic report is **not included** in this source archive.
- Terraform provisioning and AWS integration tests have **not been rerun** for this public release.
- Recovery workflows depend on real AWS backup resources and permissions.
- The repository is an academic demonstration, **not a production-ready disaster recovery solution**.

## Academic Context and Credits

**Project:** AWS DR Center — Resilience & Recovery  
**Institution:** ENSA Marrakech / Code 212 — Cadi Ayyad University  
**Academic year:** 2025–2026  
**Contributors:** Asma Bensassi Nour and Ikram Laabouki  

This work was completed as an academic end-of-year project focused on cloud resilience, cybersecurity and infrastructure automation.
