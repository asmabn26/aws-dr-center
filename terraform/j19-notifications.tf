# =========================================================
# J19 — SNS TOPIC AND EMAIL SUBSCRIPTIONS
# =========================================================

resource "aws_sns_topic" "backup_alerts" {
  name = "${local.name_prefix}-backup-alerts"

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-backup-alerts"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_sns_topic_subscription" "asma_email" {
  topic_arn = aws_sns_topic.backup_alerts.arn
  protocol  = "email"
  endpoint  = var.notification_email_asma
}

resource "aws_sns_topic_subscription" "ikram_email" {
  topic_arn = aws_sns_topic.backup_alerts.arn
  protocol  = "email"
  endpoint  = var.notification_email_ikram
}

# =========================================================
# J19 — SNS POLICY FOR EVENTBRIDGE
# =========================================================

data "aws_iam_policy_document" "sns_eventbridge_publish" {
  statement {
    sid    = "AllowEventBridgePublish"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = [
      "sns:Publish"
    ]

    resources = [
      aws_sns_topic.backup_alerts.arn
    ]
  }
}

resource "aws_sns_topic_policy" "backup_alerts" {
  arn    = aws_sns_topic.backup_alerts.arn
  policy = data.aws_iam_policy_document.sns_eventbridge_publish.json
}

# =========================================================
# J19 — EVENTBRIDGE RULES
# =========================================================

resource "aws_cloudwatch_event_rule" "backup_job_failed" {
  name        = "${local.name_prefix}-backup-job-failed"
  description = "Alert when an AWS Backup job fails"

  event_pattern = jsonencode({
    source      = ["aws.backup"]
    detail-type = ["Backup Job State Change"]
    detail = {
      state = ["FAILED", "ABORTED", "EXPIRED"]
    }
  })

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-backup-job-failed"
    backup      = "none"
    criticality = "critical"
  })
}

resource "aws_cloudwatch_event_target" "backup_job_failed_sns" {
  rule      = aws_cloudwatch_event_rule.backup_job_failed.name
  target_id = "SendToSNSBackupFailed"
  arn       = aws_sns_topic.backup_alerts.arn
}

resource "aws_cloudwatch_event_rule" "backup_job_completed" {
  name        = "${local.name_prefix}-backup-job-completed"
  description = "Notify when an AWS Backup job completes"

  event_pattern = jsonencode({
    source      = ["aws.backup"]
    detail-type = ["Backup Job State Change"]
    detail = {
      state = ["COMPLETED"]
    }
  })

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-backup-job-completed"
    backup      = "none"
    criticality = "medium"
  })
}

resource "aws_cloudwatch_event_target" "backup_job_completed_sns" {
  rule      = aws_cloudwatch_event_rule.backup_job_completed.name
  target_id = "SendToSNSBackupCompleted"
  arn       = aws_sns_topic.backup_alerts.arn
}

resource "aws_cloudwatch_event_rule" "copy_job_state" {
  name        = "${local.name_prefix}-copy-job-state"
  description = "Notify on AWS Backup copy job state changes"

  event_pattern = jsonencode({
    source      = ["aws.backup"]
    detail-type = ["Copy Job State Change"]
    detail = {
      state = ["COMPLETED", "FAILED", "ABORTED", "EXPIRED"]
    }
  })

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-copy-job-state"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_cloudwatch_event_target" "copy_job_state_sns" {
  rule      = aws_cloudwatch_event_rule.copy_job_state.name
  target_id = "SendToSNSCopyJobState"
  arn       = aws_sns_topic.backup_alerts.arn
}

resource "aws_cloudwatch_event_rule" "restore_job_state" {
  name        = "${local.name_prefix}-restore-job-state"
  description = "Notify on AWS Backup restore job state changes"

  event_pattern = jsonencode({
    source      = ["aws.backup"]
    detail-type = ["Restore Job State Change"]
    detail = {
      state = ["COMPLETED", "FAILED", "ABORTED", "EXPIRED"]
    }
  })

  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-restore-job-state"
    backup      = "none"
    criticality = "high"
  })
}

resource "aws_cloudwatch_event_target" "restore_job_state_sns" {
  rule      = aws_cloudwatch_event_rule.restore_job_state.name
  target_id = "SendToSNSRestoreJobState"
  arn       = aws_sns_topic.backup_alerts.arn
}
