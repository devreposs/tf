output "id" {
  description = "EC2 instance ID"
  value       = aws_instance.this.id
}

output "arn" {
  description = "EC2 instance ARN"
  value       = aws_instance.this.arn
}

output "security_groups" {
  description = "List of associated security groups"
  value       = aws_instance.this.vpc_security_group_ids
}

output "client_security_groups" {
  description = "Security group allowing clients access to the MS SQL Server"
  value       = aws_security_group.sg_ms_sql_clients.id
}

output "tags" {
  description = "List of tags set for the instance"
  value       = aws_instance.this.tags
}

output "volume_tags" {
  description = "List of tags set for the instance volumes"
  value       = aws_instance.this.volume_tags
}

output "private_ip" {
  description = "Private IP of the instance"
  value       = aws_instance.this.private_ip
}

output "password_parameter" {
  description = "Password Data from the instance is stored in secure string under SSM"
  value       = aws_ssm_parameter.ec2_password_data.*.name
}

output "instance_bucket" {
  description = "S3 Bucket created for dumping backups to S3"
  value       = var.create_s3_backup_bucket ? aws_s3_bucket.s3_backup_bucket[0].bucket : null
}

output "instance_bucket_arn" {
  description = "ARN of S3 Bucket created for dumping backups to S3"
  value       = var.create_s3_backup_bucket ? aws_s3_bucket.s3_backup_bucket[0].arn : null
}

output "instance_bucket_domain" {
  description = "Domain of S3 Bucket created for dumping backups to S3"
  value       = var.create_s3_backup_bucket ? aws_s3_bucket.s3_backup_bucket[0].bucket_domain_name : null
}

output "ms_sql" {
  value = {
    id                     = aws_instance.this.id
    arn                    = aws_instance.this.arn
    security_groups        = aws_instance.this.vpc_security_group_ids
    client_security_groups = aws_security_group.sg_ms_sql_clients.id
    tags                   = aws_instance.this.tags
    volume_tags            = aws_instance.this.volume_tags
    private_ip             = aws_instance.this.private_ip
    password_parameter     = aws_ssm_parameter.ec2_password_data.*.name
    s3 = {
      bucket        = var.create_s3_backup_bucket ? aws_s3_bucket.s3_backup_bucket[0].bucket : null
      bucket_arn    = var.create_s3_backup_bucket ? aws_s3_bucket.s3_backup_bucket[0].arn : null
      bucket_domain = var.create_s3_backup_bucket ? aws_s3_bucket.s3_backup_bucket[0].bucket_domain_name : null
    }
  }
}
