module "app_server_asg" {
  source  = "ptfe-crx5x8zy.deeptpe.pmicloud.xyz/core-prd/autoscaling/aws"
  version = "~> 1.0.0"
  count   = var.asg_app_server_count

  name                                   = var.app_server_name
  asg_name                               = var.asg_app_server_asg_name
  create_lc                              = var.asg_app_server_create_lc
  lc_name                                = var.asg_app_server_lc_name
  create_asg_with_initial_lifecycle_hook = var.asg_app_server_create_asg_with_initial_lifecycle_hook
  recreate_asg_when_lc_changes           = var.asg_app_server_recreate_asg_when_lc_changes

  # Input variables for initial lifecycle hook
  initial_lifecycle_hook_name                    = var.asg_app_server_initial_lifecycle_hook_name
  initial_lifecycle_hook_lifecycle_transition    = var.asg_app_server_initial_lifecycle_hook_lifecycle_transition
  initial_lifecycle_hook_default_result          = var.asg_app_server_initial_lifecycle_hook_default_result
  initial_lifecycle_hook_notification_metadata   = var.asg_app_server_initial_lifecycle_hook_notification_metadata
  initial_lifecycle_hook_heartbeat_timeout       = var.asg_app_server_initial_lifecycle_hook_heartbeat_timeout
  initial_lifecycle_hook_notification_target_arn = var.asg_app_server_initial_lifecycle_hook_notification_target_arn
  initial_lifecycle_hook_role_arn                = var.asg_app_server_initial_lifecycle_hook_role_arn

  # Input variables for launch configuration
  image_id                    = var.asg_app_server_image_id == "" ? data.aws_ami.asg_app_server_ami.id : var.asg_app_server_image_id
  instance_type               = var.asg_app_server_instance_type
  iam_instance_profile        = aws_iam_instance_profile.asg_app_server_ec2_instance_profile[0].name
  key_name                    = var.asg_app_server_key_name
  security_groups             = (var.asg_app_server_attach_db_server_security_group ? concat(aws_security_group.asg_app_server_security_group.*.id, var.additional_asg_app_server_security_groups, module.ec2_module_db_server.*.client_security_groups) : concat(aws_security_group.asg_app_server_security_group.*.id, var.additional_asg_app_server_security_groups))
  associate_public_ip_address = var.asg_app_server_associate_public_ip_address
  user_data                   = var.asg_app_server_user_data
  user_data_base64            = var.asg_app_server_user_data_base64
  enable_monitoring           = var.asg_app_server_enable_monitoring
  ebs_optimized               = var.asg_app_server_ebs_optimized
  root_block_device           = var.asg_app_server_root_block_device
  ebs_block_device            = var.asg_app_server_ebs_block_device
  ephemeral_block_device      = var.asg_app_server_ephemeral_block_device
  spot_price                  = var.asg_app_server_spot_price
  placement_tenancy           = var.asg_app_server_placement_tenancy
  launch_configuration        = var.asg_app_server_launch_configuration

  # Input variable for autoscaling group
  max_size                  = var.asg_app_server_max_size
  min_size                  = var.asg_app_server_min_size
  desired_capacity          = var.asg_app_server_desired_capacity
  vpc_zone_identifier       = var.app_server_subnet_ids
  default_cooldown          = var.asg_app_server_default_cooldown
  health_check_grace_period = var.asg_app_server_health_check_grace_period
  health_check_type         = var.asg_app_server_health_check_type
  force_delete              = var.asg_app_server_force_delete
  load_balancers            = var.asg_app_server_load_balancers
  target_group_arns         = var.asg_app_server_target_group_arns
  termination_policies      = var.asg_app_server_termination_policies
  suspended_processes       = var.asg_app_server_suspended_processes
  tags_as_map = merge(
    { "Name" = var.app_server_name },
    { "ProductCode" = var.product_code },
    { "Backup_Plan" = var.asg_app_server_backup_plan },
    { "Environment" = upper(var.env) },
    { "MaintenanceWindow" = var.app_server_ec2_maintenance_window },
    { "VPCgroup" = var.ec2_launch_vpc_group },
    { "Tier" = var.asg_app_server_tier_tag_value },
  var.asg_app_server_tags_as_map)
  placement_group           = var.asg_app_server_placement_group
  metrics_granularity       = var.asg_app_server_metrics_granularity
  enabled_metrics           = var.asg_enabled_metrics
  wait_for_capacity_timeout = var.asg_wait_for_capacity_timeout
  min_elb_capacity          = var.asg_app_server_min_elb_capacity
  wait_for_elb_capacity     = var.asg_app_server_wait_for_elb_capacity
  protect_from_scale_in     = var.asg_app_server_protect_from_scale_in
  service_linked_role_arn   = var.asg_app_server_service_linked_role_arn
  max_instance_lifetime     = var.asg_app_server_max_instance_lifetime

}
