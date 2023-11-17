resource "random_string" "db_server_suffix" {
  count   = var.db_server_ec2_instance_count
  length  = 8
  special = false
}

module "ec2_module_db_server" {
  source = "../terraform-aws-ms-sql"
  #source  = "ptfe-crx5x8zy.deeptpe.pmicloud.xyz/core-prd/ms-sql/aws"
  #version = "= 1.0.3"
  count   = var.db_server_ec2_instance_count

  # madatory input variables
  env                = var.env
  product_code       = var.product_code
  key_name           = var.key_name
  vpc_group          = var.ec2_launch_vpc_group
  subnet_id          = element(var.db_server_subnet_ids, count.index)
  name               = join("-", [var.db_server_name, "${count.index + 1}"])
  maintenance_window = var.db_server_ec2_maintenance_window

  # optional input valiables
  backup_plan    = var.db_server_ec2_backup_plan
  iam_policy_arn = local.db_server_ec2_iam_policy_arn_list
  instance_type  = var.db_server_instance_type
  sql_version    = var.db_server_sql_version
  sql_edition    = var.db_server_sql_edition
  user_data      = var.db_server_user_data

  root_volume_size             = var.db_server_ec2_root_volume_size
  ebs_volume_device            = var.db_server_ec2_ebs_volume_device
  root_volume_type             = var.db_server_root_volume_type
  root_volume_iops             = var.db_server_root_volume_iops
  root_volume_throughput       = var.db_server_root_volume_throughput
  sql_data_volume_size         = var.db_server_sql_data_volume_size
  sql_data_volume_type         = var.db_server_sql_data_volume_type
  sql_data_volume_iops         = var.db_server_sql_data_volume_iops
  sql_data_volume_throughput   = var.db_server_sql_data_volume_throughput
  sql_logs_volume_size         = var.db_server_sql_logs_volume_size
  sql_logs_volume_type         = var.db_server_sql_logs_volume_type
  sql_logs_volume_iops         = var.db_server_sql_logs_volume_iops
  sql_logs_volume_throughput   = var.db_server_sql_logs_volume_throughput
  sql_temp_volume_size         = var.db_server_sql_temp_volume_size
  sql_temp_volume_type         = var.db_server_sql_temp_volume_type
  sql_temp_volume_iops         = var.db_server_sql_temp_volume_iops
  sql_temp_volume_throughput   = var.db_server_sql_temp_volume_throughput
  sql_backup_volume_size       = var.db_server_sql_backup_volume_size
  sql_backup_volume_type       = var.db_server_sql_backup_volume_type
  sql_backup_volume_iops       = var.db_server_sql_backup_volume_iops
  sql_backup_volume_throughput = var.db_server_sql_backup_volume_throughput
  sql_data1_volume_size         = var.db_server_sql_data1_volume_size
  sql_data1_volume_type         = var.db_server_sql_data1_volume_type
  sql_data1_volume_iops         = var.db_server_sql_data1_volume_iops
  sql_data1_volume_throughput   = var.db_server_sql_data1_volume_throughput
  sql_data2_volume_size         = var.db_server_sql_data2_volume_size
  sql_data2_volume_type         = var.db_server_sql_data2_volume_type
  sql_data2_volume_iops         = var.db_server_sql_data2_volume_iops
  sql_data2_volume_throughput   = var.db_server_sql_data2_volume_throughput
  sql_data3_volume_size         = var.db_server_sql_data3_volume_size
  sql_data3_volume_type         = var.db_server_sql_data3_volume_type
  sql_data3_volume_iops         = var.db_server_sql_data3_volume_iops
  sql_data3_volume_throughput   = var.db_server_sql_data3_volume_throughput
  sql_data4_volume_size         = var.db_server_sql_data4_volume_size
  sql_data4_volume_type         = var.db_server_sql_data4_volume_type
  sql_data4_volume_iops         = var.db_server_sql_data4_volume_iops
  sql_data4_volume_throughput   = var.db_server_sql_data4_volume_throughput
  sql_data5_volume_size         = var.db_server_sql_data5_volume_size
  sql_data5_volume_type         = var.db_server_sql_data5_volume_type
  sql_data5_volume_iops         = var.db_server_sql_data5_volume_iops
  sql_data5_volume_throughput   = var.db_server_sql_data5_volume_throughput

  existing_security_groups = var.additional_db_server_security_groups
  #existing_security_groups = concat(aws_security_group.db_server_instance_security_group.*.id, var.additional_db_server_security_groups)
  allowed_ips              = var.db_server_allowed_ips_for_ssh_rdp
  db_port                  = var.db_port
  create_s3_backup_bucket  = var.db_server_create_s3_backup_bucket
  sql_backups_s3_bucket    = join("-", [var.db_server_name, random_string.db_server_suffix[count.index].result])
 tags = merge(
    { "Tier"      = var.db_server_tier_tag_value,
      "Hostindex" = count.index
  }, var.db_server_ec2_tags, local.common_tags )
  
   volume_tags = merge(  {"Tier" = var.db_server_tier_tag_value,
    "Hostindex" = count.index},
    local.common_tags, var.db_server_ec2_volume_tags)

  #depends_on = [aws_security_group.db_server_instance_security_group]
}

# Cloudwatch alarm for EC2 auto recovery
resource "aws_cloudwatch_metric_alarm" "ec2_db_server_auto_recovery_alarm" {
  count               = var.db_server_auto_recovery_alarm ? var.db_server_ec2_instance_count : 0
  alarm_name          = "AutoRecover-${element(module.ec2_module_db_server.*.id, count.index)}"
  alarm_description   = "Auto recover the EC2 instance if Status Check fails."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.instance_autorecovery_alarm_evaluation_period
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
  period              = var.instance_autorecovery_alarm_period
  statistic           = "Minimum"

  dimensions = {
    InstanceId = element(module.ec2_module_db_server.*.id, count.index)
  }

  alarm_actions = ["arn:aws:automate:${data.aws_region.current.name}:ec2:recover"]
  threshold     = var.instance_autorecovery_alarm_threshold
  tags = local.common_tags
}

data "aws_iam_policy_document" "db_server_extravar_policy_document" {
  count = var.db_server_ec2_instance_count >= 1 && var.db_server_use_ansible_configuration && var.db_server_ansible_extra_var != "" ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters"]
    resources = ["arn:aws:execute-api:${data.aws_region.region.name}:${data.aws_caller_identity.current.account_id}:parameter${var.db_server_ansible_extra_var_parameter_name}"]
  }
}

resource "aws_iam_policy" "db_server_ansible_extravar_policy" {
  count  = var.db_server_ec2_instance_count >= 1 && var.db_server_use_ansible_configuration && var.db_server_ansible_extra_var != "" ? 1 : 0
  name   = var.db_server_ansible_extra_var_parameter_policy_name
  policy = data.aws_iam_policy_document.db_server_extravar_policy_document[0].json
}
