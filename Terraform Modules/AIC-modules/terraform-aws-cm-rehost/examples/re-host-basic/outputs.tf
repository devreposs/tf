# Out put for web server resources
output "web_server_ec2_ids" {
  description = "List of instance ids"
  value       = module.re_host_basic.web_server_ec2_ids
}

output "web_server_ec2_arn" {
  description = "List of ARNs of instances"
  value       = module.re_host_basic.web_server_ec2_arn
}

output "web_server_ec2_security_groups" {
  description = "List of associated security groups of instances"
  value       = module.re_host_basic.web_server_ec2_security_groups
}

output "web_server_ec2_tags" {
  description = "List of tags of instances"
  value       = module.re_host_basic.web_server_ec2_tags
}

output "web_server_ec2_volume_tags" {
  description = "List of tags of volumes of instances"
  value       = module.re_host_basic.web_server_ec2_volume_tags
}

output "web_server_ec2_private_ip" {
  description = "Private IP for the instance"
  value       = module.re_host_basic.web_server_ec2_private_ip
}

output "web_server_ec2_public_ip" {
  description = "Public IP for the instance, if applicable."
  value       = module.re_host_basic.web_server_ec2_public_ip
}

# Out put for app server resources
output "app_server_ec2_ids" {
  description = "List of instance ids"
  value       = module.re_host_basic.app_server_ec2_ids
}

output "app_server_ec2_arn" {
  description = "List of ARNs of instances"
  value       = module.re_host_basic.app_server_ec2_arn
}

output "app_server_ec2_security_groups" {
  description = "List of associated security groups of instances"
  value       = module.re_host_basic.app_server_ec2_security_groups
}

output "app_server_ec2_tags" {
  description = "List of tags of instances"
  value       = module.re_host_basic.app_server_ec2_tags
}

output "app_server_ec2_volume_tags" {
  description = "List of tags of volumes of instances"
  value       = module.re_host_basic.app_server_ec2_volume_tags
}

output "app_server_ec2_private_ip" {
  description = "Private IP for the instance"
  value       = module.re_host_basic.app_server_ec2_private_ip
}

output "app_server_ec2_public_ip" {
  description = "Public IP for the instance, if applicable."
  value       = module.re_host_basic.app_server_ec2_public_ip
}

# Out put for database server resources
output "db_server_ec2_ids" {
  description = "List of instance ids"
  value       = module.re_host_basic.db_server_ec2_ids
}

output "db_server_ec2_arn" {
  description = "List of ARNs of instances"
  value       = module.re_host_basic.db_server_ec2_arn
}

output "db_server_ec2_security_groups" {
  description = "List of associated security groups of instances"
  value       = module.re_host_basic.db_server_ec2_security_groups
}

output "db_server_ec2_tags" {
  description = "List of tags of instances"
  value       = module.re_host_basic.db_server_ec2_tags
}

output "db_server_ec2_volume_tags" {
  description = "List of tags of volumes of instances"
  value       = module.re_host_basic.db_server_ec2_volume_tags
}

output "db_server_ec2_private_ip" {
  description = "Private IP for the instance"
  value       = module.re_host_basic.db_server_ec2_private_ip
}

output "db_server_client_security_groups" {
  description = "Security group allowing clients access to the MS SQL Server"
  value       = module.re_host_basic.db_server_client_security_groups
}

output "db_server_instance_bucket" {
  description = "S3 Bucket created for dumping backups to S3"
  value       = module.re_host_basic.db_server_instance_bucket
}

output "db_server_instance_bucket_arn" {
  description = "ARN of S3 Bucket created for dumping backups to S3"
  value       = module.re_host_basic.db_server_instance_bucket_arn
}

output "db_server_instance_bucket_domain" {
  description = "Domain of S3 Bucket created for dumping backups to S3"
  value       = module.re_host_basic.db_server_instance_bucket_domain
}

# output for asg app server resources
output "asg_app_server_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.re_host_basic.asg_app_server_launch_configuration_id
}

output "asg_app_server_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = module.re_host_basic.asg_app_server_launch_configuration_name
}

output "asg_app_server_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_id
}

output "asg_app_server_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_name
}

output "asg_app_server_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_arn
}

output "asg_app_server_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_min_size
}

output "asg_app_server_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_max_size
}

output "asg_app_server_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_desired_capacity
}

output "asg_app_server_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_default_cooldown
}

output "asg_app_server_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_health_check_grace_period
}

output "asg_app_server_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_health_check_type
}

output "asg_app_server_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_availability_zones
}

output "asg_app_server_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_vpc_zone_identifier
}

output "asg_app_server_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_load_balancers
}

output "asg_app_server_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.re_host_basic.asg_app_server_autoscaling_group_target_group_arns
}

# output for asg web server resources
output "asg_web_server_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.re_host_basic.asg_web_server_launch_configuration_id
}

output "asg_web_server_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = module.re_host_basic.asg_web_server_launch_configuration_name
}

output "asg_web_server_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_id
}

output "asg_web_server_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_name
}

output "asg_web_server_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_arn
}

output "asg_web_server_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_min_size
}

output "asg_web_server_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_max_size
}

output "asg_web_server_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_desired_capacity
}

output "asg_web_server_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_default_cooldown
}

output "asg_web_server_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_health_check_grace_period
}

output "asg_web_server_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_health_check_type
}

output "asg_web_server_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_availability_zones
}

output "asg_web_server_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_vpc_zone_identifier
}

output "asg_web_server_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_load_balancers
}

output "asg_web_server_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.re_host_basic.asg_web_server_autoscaling_group_target_group_arns
}

output "s3_logging_bucket_arn" {
  description = "S3 logging bucket arn for S3 access audit"
  value       = module.re_host_basic.s3_logging_bucket_arn
}