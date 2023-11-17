data "aws_caller_identity" "current" {}

data "terraform_remote_state" "app_baseline" {
  backend = "remote"

  config = {
    organization = "core-prd"
    hostname     = "ptfe-crx5x8zy.deeptpe.pmicloud.xyz"

    workspaces = {
      name = lookup(var.baseline_workspace_name, var.env)
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

module "re_host_advanced" {
  source = "../.."

  asg_app_server_count                        = lookup(var.asg_app_server_count, var.env)
  asg_web_server_count                        = lookup(var.asg_web_server_count, var.env)
  app_server_ec2_instance_count               = lookup(var.app_server_ec2_instance_count, var.env)
  db_server_ec2_instance_count                = lookup(var.db_server_ec2_instance_count, var.env)
  web_server_ec2_instance_count               = lookup(var.web_server_ec2_instance_count, var.env)
  app_server_platform                         = var.app_server_platform
  app_server_os                               = var.app_server_os
  db_server_platform                          = var.db_server_platform
  db_server_os                                = var.db_server_os
  web_server_platform                         = var.web_server_platform
  web_server_os                               = var.web_server_os
  web_server_instance_type                    = lookup(var.web_server_instance_type, var.env)
  app_server_instance_type                    = lookup(var.app_server_instance_type, var.env)
  db_server_instance_type                     = lookup(var.db_server_instance_type, var.env)
  web_server_user_data                        = file("install_apache.sh")
  env                                         = var.env
  web_server_ec2_ebs_volume_device            = lookup(var.web_server_ec2_ebs_volume_device, var.env)
  app_server_ec2_ebs_volume_device            = lookup(var.app_server_ec2_ebs_volume_device, var.env)
  db_server_ec2_ebs_volume_device             = lookup(var.db_server_ec2_ebs_volume_device, var.env)
  vpc_id                                      = data.terraform_remote_state.app_baseline.outputs.vpc_id_primary
  product_code                                = var.product_code
  app_server_subnet_ids                       = data.terraform_remote_state.app_baseline.outputs.private_subnets_primary
  db_server_subnet_ids                        = data.terraform_remote_state.app_baseline.outputs.database_subnets_primary
  web_server_subnet_ids                       = data.terraform_remote_state.app_baseline.outputs.private_subnets_primary
  key_name                                    = aws_key_pair.generated_key.key_name
  ec2_launch_vpc_group                        = data.terraform_remote_state.app_baseline.outputs.account_vpc_policy
  app_server_name                             = lookup(var.app_server_name, var.env)
  db_server_name                              = lookup(var.db_server_name, var.env)
  web_server_name                             = lookup(var.web_server_name, var.env)
  asg_app_server_asg_name                     = var.asg_app_server_asg_name
  asg_app_server_create_lc                    = var.asg_app_server_create_lc
  asg_web_server_asg_name                     = var.asg_web_server_asg_name
  asg_web_server_create_lc                    = var.asg_web_server_create_lc
  asg_app_server_lc_name                      = var.asg_app_server_lc_name
  asg_web_server_lc_name                      = var.asg_web_server_lc_name
  asg_app_server_recreate_asg_when_lc_changes = lookup(var.asg_app_server_recreate_asg_when_lc_changes, var.env)
  asg_web_server_recreate_asg_when_lc_changes = lookup(var.asg_web_server_recreate_asg_when_lc_changes, var.env)
  asg_app_server_instance_type                = lookup(var.asg_app_server_instance_type, var.env)
  additional_web_server_security_groups       = [aws_security_group.web_server_additional_security_group.id]
  additional_app_server_security_groups       = [aws_security_group.app_server_additional_security_group.id]
  additional_db_server_security_groups        = [aws_security_group.db_server_additional_security_group.id]
  asg_app_server_associate_public_ip_address  = var.asg_app_server_associate_public_ip_address
  asg_app_server_user_data                    = file("install_apache.sh")
  asg_app_server_enable_monitoring            = lookup(var.asg_app_server_enable_monitoring, var.env)
  asg_app_server_ebs_optimized                = lookup(var.asg_app_server_ebs_optimized, var.env)
  asg_app_server_spot_price                   = lookup(var.asg_app_server_spot_price, var.env)
  asg_app_server_max_size                     = lookup(var.asg_app_server_max_size, var.env)
  asg_app_server_min_size                     = lookup(var.asg_app_server_min_size, var.env)
  asg_app_server_desired_capacity             = lookup(var.asg_app_server_desired_capacity, var.env)
  asg_app_server_force_delete                 = var.asg_app_server_force_delete
  asg_app_server_suspended_processes          = lookup(var.asg_app_server_suspended_processes, var.env)

  depends_on = [
    aws_security_group.web_server_additional_security_group,
    aws_security_group.app_server_additional_security_group,
    aws_security_group.db_server_additional_security_group
  ]
}
