# AWS provider and region
data "aws_caller_identity" "current" {}

locals {
  baseline_version = "v0.0.2"
  common_tags = {
    ProductCode               = data.terraform_remote_state.app-baseline.outputs.account_short_name
    Backup_Plan               = var.backup_plan
    Environment               = upper(var.environment)
    MaintenanceWindow         = var.db_server_ec2_maintenance_window
    stack_env                 = var.environment
    security_data_sensitivity = "protected"
    stack                     = var.name
    stack_version             = "0.1.0"
    stack_lifecycle           = "perm"
    VPCgroup                  = "lands"
    project                   = "pmi-app-${var.short_name}-${var.environment}"
  }
  nlb_name = "nlb-${var.product_code}-${var.environment}"
}

data "terraform_remote_state" "app-baseline" {
  backend = "remote"

  config = {
    organization = var.tfe_org_name
    hostname     = var.tfe_host_name

    workspaces = {
      name = var.baseline_workspace_name
    }
  }
}

provider "aws" {
  region = data.terraform_remote_state.app-baseline.outputs.region
}
module "ec2_module_app_server" {
  source  = "example.com/core-prd/ec2-module/aws"
  version = "= 1.4.3"
  count   = var.app_server_ec2_instance_count
  name               = join("-", [var.app_server_name, "${count.index + 1}"])
  subnet_id          = element(var.app_server_subnet_ids, count.index)
  tags = merge({ "Tier" = var.app_server_tier_tag_value, "Hostindex" = count.index }, var.app_server_ec2_tags, local.common_tags)

}
