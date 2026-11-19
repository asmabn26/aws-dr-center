# =========================================================
# J19 — CLOUDWATCH DASHBOARD
# =========================================================

resource "aws_cloudwatch_dashboard" "backup_drp" {
  dashboard_name = var.cloudwatch_dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 2

        properties = {
          markdown = "# PFA AWS Backup & DRP — Supervision\nDashboard de suivi des sauvegardes, restaurations, copies DR et recovery points."
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 2
        width  = 12
        height = 6

        properties = {
          title   = "Backup jobs — Completed vs Failed"
          region  = var.aws_region
          view    = "timeSeries"
          stacked = false
          period  = 300
          stat    = "Sum"

          metrics = [
            ["AWS/Backup", "NumberOfBackupJobsCompleted", "BackupVaultName", aws_backup_vault.primary.name],
            [".", "NumberOfBackupJobsFailed", ".", "."],
            [".", "NumberOfBackupJobsRunning", ".", "."],
            [".", "NumberOfBackupJobsCreated", ".", "."]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 2
        width  = 12
        height = 6

        properties = {
          title   = "Restore jobs — Completed vs Failed"
          region  = var.aws_region
          view    = "timeSeries"
          stacked = false
          period  = 300
          stat    = "Sum"

          metrics = [
            ["AWS/Backup", "NumberOfRestoreJobsCompleted", "BackupVaultName", aws_backup_vault.primary.name],
            [".", "NumberOfRestoreJobsFailed", ".", "."],
            [".", "NumberOfRestoreJobsRunning", ".", "."]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 8
        width  = 12
        height = 6

        properties = {
          title   = "Copy jobs DR — Completed vs Failed"
          region  = var.aws_region
          view    = "timeSeries"
          stacked = false
          period  = 300
          stat    = "Sum"

          metrics = [
            ["AWS/Backup", "NumberOfCopyJobsCompleted", "BackupVaultName", aws_backup_vault.dr.name],
            [".", "NumberOfCopyJobsFailed", ".", "."],
            [".", "NumberOfCopyJobsRunning", ".", "."]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 8
        width  = 12
        height = 6

        properties = {
          title   = "Recovery points — Completed"
          region  = var.aws_region
          view    = "timeSeries"
          stacked = false
          period  = 300
          stat    = "Sum"

          metrics = [
            ["AWS/Backup", "NumberOfRecoveryPointsCompleted", "BackupVaultName", aws_backup_vault.primary.name]
          ]
        }
      }
    ]
  })
}