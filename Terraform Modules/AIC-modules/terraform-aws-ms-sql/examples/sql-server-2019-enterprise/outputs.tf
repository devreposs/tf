output "id" {
  description = "EC2 instance ID"
  value       = module.sql_2019_module.id
}

output "arn" {
  description = "EC2 instance ARN"
  value       = module.sql_2019_module.arn
}

output "security_groups" {
  description = "List of associated security groups"
  value       = module.sql_2019_module.security_groups
}

output "tags" {
  description = "List of tags set for the instance"
  value       = module.sql_2019_module.tags
}

output "volume_tags" {
  description = "List of tags set for the instance volumes"
  value       = module.sql_2019_module.volume_tags
}

output "private_ip" {
  description = "Private IP of the instance"
  value       = module.sql_2019_module.private_ip
}

output "password_parameter" {
  description = "Password Data from the instance is stored in secure string under SSM"
  value       = module.sql_2019_module.password_parameter
}

## New format
output "sql_2019" {
  value = {
    id                 = module.sql_2019_module.ms_sql.id
    arn                = module.sql_2019_module.ms_sql.arn
    tags               = module.sql_2019_module.ms_sql.tags
    value              = module.sql_2019_module.ms_sql.security_groups
    volume_tags        = module.sql_2019_module.ms_sql.volume_tags
    private_ip         = module.sql_2019_module.ms_sql.private_ip
    password_parameter = module.sql_2019_module.ms_sql.password_parameter
    s3_backup_bucket   = module.sql_2019_module.ms_sql.s3.bucket  
  }
}
