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

provider "aws" {
  region = data.terraform_remote_state.app_baseline.outputs.region
}

module "re_host_basic" {
  source = "../.."

  asg_app_server_count            = var.asg_app_server_count
  asg_web_server_count            = var.asg_web_server_count
  app_server_ec2_instance_count   = var.app_server_ec2_instance_count
  db_server_ec2_instance_count    = var.db_server_ec2_instance_count
  web_server_ec2_instance_count   = var.web_server_ec2_instance_count
  env                             = var.env
  vpc_id                          = data.terraform_remote_state.app_baseline.outputs.vpc_id_primary
  product_code                    = var.product_code
  app_server_subnet_ids           = data.terraform_remote_state.app_baseline.outputs.private_subnets_primary
  db_server_subnet_ids            = data.terraform_remote_state.app_baseline.outputs.private_subnets_primary
  web_server_subnet_ids           = data.terraform_remote_state.app_baseline.outputs.private_subnets_primary
  key_name                        = aws_key_pair.generated_key.key_name
  ec2_launch_vpc_group            = data.terraform_remote_state.app_baseline.outputs.account_vpc_policy
  app_server_name                 = var.app_server_name
  db_server_name                  = var.db_server_name
  web_server_name                 = var.web_server_name
  asg_app_server_max_size         = var.asg_app_server_max_size
  asg_app_server_min_size         = var.asg_app_server_min_size
  asg_app_server_desired_capacity = var.asg_app_server_desired_capacity
  asg_web_server_max_size         = var.asg_web_server_max_size
  asg_web_server_min_size         = var.asg_web_server_min_size
  asg_web_server_desired_capacity = var.asg_web_server_desired_capacity
}
