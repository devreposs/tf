data "aws_region" "current" {}

data "aws_vpc" "instance_vpc" {
  id = var.vpc_id
}

data "aws_ami" "asg_app_server_ami" {
  most_recent = true
  owners      = ["630707141366"]
  filter {
    name   = "name"
    values = [lookup(local.ami_filter_list, local.asg_app_server_os)]
  }
}

data "aws_ami" "asg_web_server_ami" {
  most_recent = true
  owners      = ["630707141366"]
  filter {
    name   = "name"
    values = [lookup(local.ami_filter_list, local.asg_web_server_os)]
  }
}
