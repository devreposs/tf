locals {
  accepted_sql_versions = {
    2016 = "2016"
    2019 = "2019"
  }
  accepted_sql_editions = {
    standard   = "standard"
    enterprise = "enterprise"
  }
  accepted_volume_types = {
    gp2 = "gp2"
    gp3 = "gp3"
    io1 = "io1"
    io2 = "io2"
  }
  selected_sql_version        = local.accepted_sql_versions[var.sql_version] # If this fails, the tier variable is invalid
  selected_sql_edition        = local.accepted_sql_editions[var.sql_edition] # If this fails, the tier variable is invalid
  selected_sql_filter         = "${var.sql_edition}${var.sql_version}"
  selected_root_volume_type   = local.accepted_volume_types[var.root_volume_type]       # If this fails, the tier variable is invalid
  selected_data_volume_type   = local.accepted_volume_types[var.sql_data_volume_type]   # If this fails, the tier variable is invalid
  selected_logs_volume_type   = local.accepted_volume_types[var.sql_logs_volume_type]   # If this fails, the tier variable is invalid
  selected_temp_volume_type   = local.accepted_volume_types[var.sql_temp_volume_type]   # If this fails, the tier variable is invalid
  selected_backup_volume_type = local.accepted_volume_types[var.sql_backup_volume_type] # If this fails, the tier variable is invalid
}

variable "name" {
  description = "Name to be used on all resources as prefix"
  type        = string

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^[a-zA-Z0-9-]*$", var.name))
    error_message = "The name value must only have alpha numerical and - ."
  }
}

variable "sql_version" {
  description = "SQl server version - 2016 or 2019"
  type        = string
}

variable "sql_edition" {
  description = "SQl server version - enterprise or standard"
  type        = string
}

variable "sql_backups_s3_bucket" {
  description = "S3 bucket name for MSSQL backups"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "ec2_security_group_prefix" {
  description = "Prefix of security group name to create"
  type        = string
  default     = "ec2_module_instance_security_group"
}

variable "allowed_ips" {
  type        = list(string)
  description = "List of IP addresses that have SSH or RDP access to the instance"
  default     = []
}

variable "user_data" {
  description = "Contents of EC2 user-data"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "def_tags" {
  description = "A map of default tags to add to all resources"

  default = {
    "Terraform" = "true"
  }
}


variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "existing_security_groups" {
  description = "Specify a list of security group ids that the instance should have"
  type        = list(string)
  default     = []
}

variable "iam_policy_arn" {
  description = "List of policies to be assigned to the EC2 Instance"
  type        = map(string)
  default     = {}
}

variable "product_code" {
  description = "Unique identifier across the whole DEEP platform"
}

variable "backup_plan" {
  description = "A tag for back up plan that needs to be specified"
  type        = string
  default     = "default"
}

variable "env" {
  description = "Environment for the EC2 Instance"
  type        = string
}

variable "maintenance_window" {
  description = "Specifying maintenance window for the EC2 Instance"
  type        = string
  validation {
    condition     = can(regex("^(MON|TUE|WED|THU|FRI|SAT|SUN)_(0[0-9]|1[0-9]|2[0-3])$", var.maintenance_window))
    error_message = "Please make sure the format is DDD_HH, where DDD is day of week (MON,TUE,WED,THU,FRI,SAT,SUN) and HH is hour of day (00-23)."
  }
  default = "TUE_01"
}

variable "vpc_group" {
  description = "Specifying vpc mode tag for the EC2 Instance"
  type        = string
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
}

variable "root_volume_size" {
  description = "Volume size for the root block device of the instance"
  default     = "70"
}

variable "root_volume_type" {
  description = "Volume type for the root block device of the instance"
  default     = "gp3"
}

variable "root_volume_iops" {
  description = "Volume iops for the root block device of the instance"
  default     = "0"
}

variable "root_volume_throughput" {
  description = "Volume throughput for the root block device of the instance"
  default     = "0"
}

variable "sql_data_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "sql_data_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "sql_data_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_logs_volume_size" {
  description = "Volume size for the SQL Logs"
  default     = "10"
}

variable "sql_logs_volume_type" {
  description = "Volume type for the SQL Logs"
  default     = "gp3"
}

variable "sql_logs_volume_iops" {
  description = "Volume iops for the SQL Logs"
  default     = "0"
}

variable "sql_logs_volume_throughput" {
  description = "Volume throughput for the SQL Logs"
  default     = "0"
}

variable "sql_temp_volume_size" {
  description = "Volume size for the SQL Tempdb"
  default     = "10"
}

variable "sql_temp_volume_type" {
  description = "Volume type for the SQL Tempdb"
  default     = "gp3"
}

variable "sql_temp_volume_iops" {
  description = "Volume iops for the SQL Tempdb"
  default     = "0"
}

variable "sql_temp_volume_throughput" {
  description = "Volume throughput for the SQL Tempdb"
  default     = "0"
}

variable "sql_backup_volume_size" {
  description = "Volume size for the SQL Backups"
  default     = "10"
}

variable "sql_backup_volume_type" {
  description = "Volume type for the SQL Backups"
  default     = "gp3"
}

variable "sql_backup_volume_iops" {
  description = "Volume iops for the SQL Backups"
  default     = "0"
}

variable "sql_backup_volume_throughput" {
  description = "Volume throughput for the SQL Backups"
  default     = "0"
}


variable "sql_data1_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "sql_data1_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "sql_data1_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data1_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data2_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "sql_data2_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "sql_data2_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data2_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data3_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "sql_data3_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "sql_data3_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data3_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data4_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "sql_data4_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "sql_data4_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data4_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data5_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "sql_data5_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "sql_data5_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "sql_data5_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "ebs_volume_device" {
  description = "EBS volumes to be created that needs to be attached to the instance"
  type        = map(map(string))
  default     = {}
}
variable "create_s3_backup_bucket" {
  description = "Create S3 bucket for backups"
  type        = bool
  default     = true
}

variable "db_port" {
  description = "Port that database should listen to. Used for SecurityGroups and instance config"
  default     = "1433"
}
