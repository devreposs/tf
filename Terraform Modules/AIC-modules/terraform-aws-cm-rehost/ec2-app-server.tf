resource "random_string" "app_server_suffix" {
  count   = var.app_server_ec2_instance_count
  length  = 8
  special = false
}

# Resource for app server layer
module "ec2_module_app_server" {
  source  = "ptfe-crx5x8zy.deeptpe.pmicloud.xyz/core-prd/ec2-module/aws"
  version = "= 1.4.3"
  count   = var.app_server_ec2_instance_count

  # madatory input variables
  env                = var.env
  key_name           = var.key_name
  vpc_group          = var.ec2_launch_vpc_group
  name               = join("-", [var.app_server_name, "${count.index + 1}"])
  instance_type      = var.app_server_instance_type
  maintenance_window = var.app_server_ec2_maintenance_window
  product_code       = var.product_code
  subnet_id          = element(var.app_server_subnet_ids, count.index)

  # optional input variables
  platform                 = var.app_server_platform
  os                       = var.app_server_os
  backup_plan              = var.app_server_ec2_backup_plan
  iam_policy_arn           = local.app_server_ec2_iam_policy_arn_list
  existing_security_groups = var.additional_app_server_security_groups
  #existing_security_groups = (var.app_server_attach_db_server_security_group ? concat(aws_security_group.app_server_instance_security_group.*.id, var.additional_app_server_security_groups, module.ec2_module_db_server.*.client_security_groups) : concat(aws_security_group.app_server_instance_security_group.*.id, var.additional_app_server_security_groups))
  allowed_ips              = var.app_server_allowed_ips_for_ssh_rdp
  root_volume_size         = var.app_server_ec2_root_volume_size
  ebs_volume_device        = var.app_server_ec2_ebs_volume_device
  user_data                = var.app_server_user_data
  tags = merge(
    { "Tier" = var.app_server_tier_tag_value,
    "Hostindex" = count.index },
  var.app_server_ec2_tags, local.common_tags)

  volume_tags = merge( {"Tier" = var.app_server_tier_tag_value,
    "Hostindex" = count.index },
    local.common_tags, var.app_server_ec2_volume_tags)
  
  #depends_on = [aws_security_group.app_server_instance_security_group]
  
}

# Cloudwatch alarm for EC2 auto recovery
resource "aws_cloudwatch_metric_alarm" "ec2_app_server_auto_recovery_alarm" {
  count               = var.app_server_auto_recovery_alarm ? var.app_server_ec2_instance_count : 0
  alarm_name          = "AutoRecover-${element(module.ec2_module_app_server.*.id, count.index)}"
  alarm_description   = "Auto recover the EC2 instance if Status Check fails."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.instance_autorecovery_alarm_evaluation_period
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = var.instance_autorecovery_alarm_period
  statistic           = "Minimum"

  dimensions = {
    InstanceId = element(module.ec2_module_app_server.*.id, count.index)
  }

  alarm_actions = ["arn:aws:automate:${data.aws_region.current.name}:ec2:recover"]
  threshold     = var.instance_autorecovery_alarm_threshold
  tags = local.common_tags
}

data "aws_iam_policy_document" "app_server_extravar_policy_document" {
  count = var.app_server_ec2_instance_count >= 1 && var.app_server_use_ansible_configuration && var.app_server_ansible_extra_var != "" ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters"]
    resources = ["arn:aws:execute-api:${data.aws_region.region.name}:${data.aws_caller_identity.current.account_id}:parameter${var.app_server_ansible_extra_var_parameter_name}"]
  }
}

resource "aws_iam_policy" "app_server_ansible_extravar_policy" {
  count  = var.app_server_ec2_instance_count >= 1 && var.app_server_use_ansible_configuration && var.app_server_ansible_extra_var != "" ? 1 : 0
  name   = var.app_server_ansible_extra_var_parameter_policy_name
  policy = data.aws_iam_policy_document.app_server_extravar_policy_document[0].json
}
