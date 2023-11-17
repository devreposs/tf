/*
# AWS provider and region
data "aws_caller_identity" "current" {}

data "terraform_remote_state" "app_baseline" {
  backend = "remote"

  config = {
    organization = "core-prd"
    hostname     = "ptfe-crx5x8zy.deeptpe.pmicloud.xyz"

    workspaces = {
      name = var.baseline_workspace_name
    }
  }
}

provider "aws" {
  region = data.terraform_remote_state.app_baseline.outputs.region
}

resource "aws_security_group" "existing_sg" {
  vpc_id      = data.terraform_remote_state.app_baseline.outputs.vpc_id_primary
  name_prefix = "sql_2016_module_additional_security_group"
  tags        = { Name = "sql_2016_module_additional_security_group" }
}

resource "random_string" "random" {
  length  = 8
  special = false
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "generated_key" {
  key_name   = join("-", ["testkey", random_string.random.result])
  public_key = tls_private_key.key.public_key_openssh
}

module "sql_2016_module" {
  source                   = "../../"
  name                     = var.name
  sql_version              = local.sql_version
  sql_edition              = local.sql_edition
  sql_backups_s3_bucket    = local.sql_backups_s3_bucket
  create_s3_backup_bucket  = local.create_s3_backup_bucket
  instance_type            = local.instance_type
  product_code             = var.product_code
  env                      = local.env
  vpc_group                = data.terraform_remote_state.app_baseline.outputs.account_vpc_policy
  subnet_id                = data.terraform_remote_state.app_baseline.outputs.private_subnets_primary[0]
  key_name                 = aws_key_pair.generated_key.key_name
  existing_security_groups = [aws_security_group.existing_sg.id]
  maintenance_window       = local.maintenance_window
}
*/