locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    project         = var.project_name
    environment     = var.environment
    owner           = var.owner
    managed-by      = "terraform"
    backup          = "none"
    criticality     = "medium"
    expiration-date = var.expiration_date
  }
}