# variables for ec2-module for database server layer
variable "db_server_ec2_instance_count" {
  description = "Number of instances to launch in database server layer"
  type        = number
  default     = 0
}

variable "db_server_ec2_root_volume_size" {
  description = "Volume size for the root block device of the instance"
  default     = "70"
}

variable "db_server_ec2_iam_policy_arn" {
  description = "List of policies to be assigned to the EC2 Instance"
  type        = map(string)
  default     = {}
}

variable "db_server_ec2_backup_plan" {
  description = "A tag for back up plan that needs to be specified"
  type        = string
  default     = "default"
}

variable "db_server_ec2_ebs_volume_device" {
  description = "EBS volumes to be created that needs to be attached to the instance"
  type        = map(map(string))
  default     = {}
}

variable "db_server_auto_recovery_alarm" {
  description = "Create auto recovery alarm for db instances"
  type        = bool
  default     = false
}

variable "db_server_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "r5.large"
}

variable "db_server_sql_version" {
  description = "SQl server version - 2016 or 2019"
  type        = string
  default     = "2016"
}

variable "db_server_sql_edition" {
  description = "SQl server version - enterprise or standard"
  type        = string
  default     = "standard"
}

variable "db_server_user_data" {
  description = "Contents of EC2 user-data"
  type        = string
  default     = ""
}

variable "db_server_ec2_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "db_server_ec2_volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "additional_db_server_security_groups" {
  description = "Specify a list of security group ids that the instance should have"
  type        = list(string)
  default     = []
}

variable "db_server_join_domain" {
  description = "whether db server will join PMINTL.NET domain"
  type        = bool
  default     = false
}

variable "db_server_create_s3_backup_bucket" {
  description = "Create S3 bucket for backups"
  type        = bool
  default     = true
}

variable "db_port" {
  description = "Port that database should listen to. Used for SecurityGroups and instance config"
  default     = "1433"
}

variable "db_server_root_volume_type" {
  description = "Volume type for the root block device of the instance"
  default     = "gp3"
}

variable "db_server_root_volume_iops" {
  description = "Volume iops for the root block device of the instance"
  default     = "0"
}

variable "db_server_root_volume_throughput" {
  description = "Volume throughput for the root block device of the instance"
  default     = "0"
}

variable "db_server_sql_data_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "db_server_sql_data_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "db_server_sql_data_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_logs_volume_size" {
  description = "Volume size for the SQL Logs"
  default     = "10"
}

variable "db_server_sql_logs_volume_type" {
  description = "Volume type for the SQL Logs"
  default     = "gp3"
}

variable "db_server_sql_logs_volume_iops" {
  description = "Volume iops for the SQL Logs"
  default     = "0"
}

variable "db_server_sql_logs_volume_throughput" {
  description = "Volume throughput for the SQL Logs"
  default     = "0"
}

variable "db_server_sql_temp_volume_size" {
  description = "Volume size for the SQL Tempdb"
  default     = "10"
}

variable "db_server_sql_temp_volume_type" {
  description = "Volume type for the SQL Tempdb"
  default     = "gp3"
}

variable "db_server_sql_temp_volume_iops" {
  description = "Volume iops for the SQL Tempdb"
  default     = "0"
}

variable "db_server_sql_temp_volume_throughput" {
  description = "Volume throughput for the SQL Tempdb"
  default     = "0"
}

variable "db_server_sql_backup_volume_size" {
  description = "Volume size for the SQL Backups"
  default     = "10"
}

variable "db_server_sql_backup_volume_type" {
  description = "Volume type for the SQL Backups"
  default     = "gp3"
}

variable "db_server_sql_backup_volume_iops" {
  description = "Volume iops for the SQL Backups"
  default     = "0"
}

variable "db_server_sql_backup_volume_throughput" {
  description = "Volume throughput for the SQL Backups"
  default     = "0"
}

variable "db_server_sql_data1_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "db_server_sql_data1_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "db_server_sql_data1_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data1_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data2_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "db_server_sql_data2_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "db_server_sql_data2_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data2_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data3_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "db_server_sql_data3_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "db_server_sql_data3_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data3_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data4_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "db_server_sql_data4_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "db_server_sql_data4_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data4_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data5_volume_size" {
  description = "Volume size for the SQL Data"
  default     = "10"
}

variable "db_server_sql_data5_volume_type" {
  description = "Volume type for the SQL Data"
  default     = "gp3"
}

variable "db_server_sql_data5_volume_iops" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_sql_data5_volume_throughput" {
  description = "Volume iops for the SQL Data"
  default     = "0"
}

variable "db_server_tier_tag_value" {
  description = "Tier tag value for dbserver"
  type        = string
  default     = "dbserver"
}

variable "db_server_use_ansible_configuration" {
  description = "Allows set up to call ansible jobtempalte from SSM association"
  type        = bool
  default     = false
}

variable "db_server_ansible_extra_var_parameter_name" {
  description = "Ansible dbserver extra var parameter name"
  type        = string
  default     = "/ansible/dbserver/extravar"
}

variable "db_server_ansible_extra_var_parameter_policy_name" {
  description = "Ansible dbserver extra var parameter name"
  type        = string
  default     = "dbserver-ansible-extravar-parameter-store-policy"
}

variable "db_server_ansible_extra_var" {
  description = "Ansible webserver extravar"
  type        = string
  default     = ""
}

variable "db_server_ansible_jobtemplatename" {
  description = "Ansible dbserver jobtemplate name pmi-app-<project_code>-<environment>-ansible-job-template"
  type        = string
  default     = ""
}

variable "db_server_association_name" {
  description = "SSM Association name for dbserver"
  type        = string
  default     = "db-server-association-ansible-config"
}
