# Out put for web server resources
output "web_server_ec2_ids" {
  description = "List of instance ids"
  value       = module.ec2_module_web_server.*.id
}

output "web_server_ec2_arn" {
  description = "List of ARNs of instances"
  value       = module.ec2_module_web_server.*.arn
}

output "web_server_ec2_security_groups" {
  description = "List of associated security groups of instances"
  value       = module.ec2_module_web_server.*.security_groups
}

output "web_server_ec2_tags" {
  description = "List of tags of instances"
  value       = module.ec2_module_web_server.*.tags
}

output "web_server_ec2_volume_tags" {
  description = "List of tags of volumes of instances"
  value       = module.ec2_module_web_server.*.volume_tags
}

output "web_server_ec2_private_ip" {
  description = "Private IP for the instance"
  value       = module.ec2_module_web_server.*.private_ip
}

output "web_server_ec2_public_ip" {
  description = "Public IP for the instance, if applicable."
  value       = module.ec2_module_web_server.*.public_ip
}

# Out put for app server resources
output "app_server_ec2_ids" {
  description = "List of instance ids"
  value       = module.ec2_module_app_server.*.id
}

output "app_server_ec2_arn" {
  description = "List of ARNs of instances"
  value       = module.ec2_module_app_server.*.arn
}

output "app_server_ec2_security_groups" {
  description = "List of associated security groups of instances"
  value       = module.ec2_module_app_server.*.security_groups
}

output "app_server_ec2_tags" {
  description = "List of tags of instances"
  value       = module.ec2_module_app_server.*.tags
}

output "app_server_ec2_volume_tags" {
  description = "List of tags of volumes of instances"
  value       = module.ec2_module_app_server.*.volume_tags
}

output "app_server_ec2_private_ip" {
  description = "Private IP for the instance"
  value       = module.ec2_module_app_server.*.private_ip
}

output "app_server_ec2_public_ip" {
  description = "Public IP for the instance, if applicable."
  value       = module.ec2_module_app_server.*.public_ip
}

# Out put for database server resources
output "db_server_ec2_ids" {
  description = "List of instance ids"
  value       = module.ec2_module_db_server.*.id
}

output "db_server_ec2_arn" {
  description = "List of ARNs of instances"
  value       = module.ec2_module_db_server.*.arn
}

output "db_server_ec2_security_groups" {
  description = "List of associated security groups of instances"
  value       = module.ec2_module_db_server.*.security_groups
}

output "db_server_client_security_groups" {
  description = "Security group allowing clients access to the MS SQL Server"
  value       = module.ec2_module_db_server.*.client_security_groups
}

output "db_server_ec2_tags" {
  description = "List of tags of instances"
  value       = module.ec2_module_db_server.*.tags
}

output "db_server_ec2_volume_tags" {
  description = "List of tags of volumes of instances"
  value       = module.ec2_module_db_server.*.volume_tags
}

output "db_server_ec2_private_ip" {
  description = "Private IP for the instance"
  value       = module.ec2_module_db_server.*.private_ip
}

output "db_server_instance_bucket" {
  description = "S3 Bucket created for dumping backups to S3"
  value       = module.ec2_module_db_server.*.instance_bucket
}

output "db_server_instance_bucket_arn" {
  description = "ARN of S3 Bucket created for dumping backups to S3"
  value       = module.ec2_module_db_server.*.instance_bucket_arn
}

output "db_server_instance_bucket_domain" {
  description = "Domain of S3 Bucket created for dumping backups to S3"
  value       = module.ec2_module_db_server.*.instance_bucket_domain
}

# output for asg app server resources
output "asg_app_server_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.app_server_asg.*.this_launch_configuration_id
}

output "asg_app_server_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = module.app_server_asg.*.this_launch_configuration_name
}

output "asg_app_server_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.app_server_asg.*.this_autoscaling_group_id
}

output "asg_app_server_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.app_server_asg.*.this_autoscaling_group_name
}

output "asg_app_server_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.app_server_asg.*.this_autoscaling_group_arn
}

output "asg_app_server_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.app_server_asg.*.this_autoscaling_group_min_size
}

output "asg_app_server_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.app_server_asg.*.this_autoscaling_group_max_size
}

output "asg_app_server_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.app_server_asg.*.this_autoscaling_group_desired_capacity
}

output "asg_app_server_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.app_server_asg.*.this_autoscaling_group_default_cooldown
}

output "asg_app_server_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.app_server_asg.*.this_autoscaling_group_health_check_grace_period
}

output "asg_app_server_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.app_server_asg.*.this_autoscaling_group_health_check_type
}

output "asg_app_server_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.app_server_asg.*.this_autoscaling_group_availability_zones
}

output "asg_app_server_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.app_server_asg.*.this_autoscaling_group_vpc_zone_identifier
}

output "asg_app_server_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.app_server_asg.*.this_autoscaling_group_load_balancers
}

output "asg_app_server_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.app_server_asg.*.this_autoscaling_group_target_group_arns
}

# output for asg web server resources
output "asg_web_server_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.web_server_asg.*.this_launch_configuration_id
}

output "asg_web_server_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = module.web_server_asg.*.this_launch_configuration_name
}

output "asg_web_server_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.web_server_asg.*.this_autoscaling_group_id
}

output "asg_web_server_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.web_server_asg.*.this_autoscaling_group_name
}

output "asg_web_server_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.web_server_asg.*.this_autoscaling_group_arn
}

output "asg_web_server_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.web_server_asg.*.this_autoscaling_group_min_size
}

output "asg_web_server_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.web_server_asg.*.this_autoscaling_group_max_size
}

output "asg_web_server_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.web_server_asg.*.this_autoscaling_group_desired_capacity
}

output "asg_web_server_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.web_server_asg.*.this_autoscaling_group_default_cooldown
}

output "asg_web_server_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.web_server_asg.*.this_autoscaling_group_health_check_grace_period
}

output "asg_web_server_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.web_server_asg.*.this_autoscaling_group_health_check_type
}

output "asg_web_server_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.web_server_asg.*.this_autoscaling_group_availability_zones
}

output "asg_web_server_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.web_server_asg.*.this_autoscaling_group_vpc_zone_identifier
}

output "asg_web_server_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.web_server_asg.*.this_autoscaling_group_load_balancers
}

output "asg_web_server_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.web_server_asg.*.this_autoscaling_group_target_group_arns
}

output "s3_logging_bucket_arn" {
  description = "S3 logging bucket arn for S3 access audit"
  value       = var.create_s3_logging_bucket ? module.s3-bucket-log[0].this_s3_bucket_id : ""
}

output "service_account_secret_arn" {
  description = "service account secret arn"
  value       = length(aws_secretsmanager_secret.account_secret) > 0 ? aws_secretsmanager_secret.account_secret[0].arn : ""
}

output "artifactory_secret_arn" {
  description = "artifactory secret arn"
  value       = length(aws_secretsmanager_secret.artifactory_secret) > 0 ? aws_secretsmanager_secret.artifactory_secret[0].arn : ""
}

output "secret_manager_read_policy_arn" {
  description = "secret manager read policy arn"
  value       = length(local.secret_manager_arn_list) > 0 ? aws_iam_policy.secret_manager_read_policy[0].arn : ""
}

output "domainjoin_lambda_invoke_policy_arn" {
  description = "domainjoin lambda invoke policy arn"
  value       = (length(var.domain_join_lambda_config) > 0 && (var.asg_app_server_join_domain || var.asg_web_server_join_domain || var.app_server_join_domain || var.db_server_join_domain || var.web_server_join_domain)) ? aws_iam_policy.domainjoin_lambda_invoke_policy[0].arn : ""
}
