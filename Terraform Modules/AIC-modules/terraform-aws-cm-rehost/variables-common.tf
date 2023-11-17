# common variables for all modules
variable "env" {
  description = "Environment i.e. dev/qa/prd"
  type        = string
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "product_code" {
  description = "Unique identifier across the whole DEEP platform"
  type        = string
}

variable "web_server_subnet_ids" {
  description = "Number of instances to launch in application layer"
  type        = list(string)
  default     = []
}

variable "app_server_subnet_ids" {
  description = "Number of instances to launch in service layer"
  type        = list(string)
  default     = []
}

variable "db_server_subnet_ids" {
  description = "Number of instances to launch in database layer"
  type        = list(string)
  default     = []
}

# variables for common ec2-module
variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "ec2_launch_vpc_group" {
  description = "Specifying vpc mode tag for the EC2 Instance. example: hybrid/lands/greenfield etc"
  type        = string
}

variable "instance_autorecovery_alarm_evaluation_period" {
  description = "ec2 instance autorecovery evaluation period"
  type        = string
  default     = "3"
}

variable "instance_autorecovery_alarm_period" {
  description = "ec2 instance autorecovery period(seconds)"
  type        = string
  default     = "60"
}

variable "instance_autorecovery_alarm_threshold" {
  description = "ec2 instance autorecovery threshold"
  type        = string
  default     = "1"
}

variable "asg_enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are `GroupMinSize`, `GroupMaxSize`, `GroupDesiredCapacity`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupTerminatingInstances`, `GroupTotalInstances`"
  type        = list(string)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "asg_wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
  type        = string
  default     = "10m"
}

variable "app_server_name" {
  description = "Name to be used on all resources as prefix in app layer"
  type        = string
  default     = ""
}

variable "db_server_name" {
  description = "Name to be used on all resources as prefix in db layer"
  type        = string
  default     = ""
}

variable "web_server_name" {
  description = "Name to be used on all resources as prefix in web layer"
  type        = string
  default     = ""
}

variable "app_server_allowed_ips_for_ssh_rdp" {
  description = "List of IP addresses that have SSH or RDP access to the instance"
  type        = list(string)
  default     = []
}

variable "db_server_allowed_ips_for_ssh_rdp" {
  description = "List of IP addresses that have SSH or RDP access to the instance"
  type        = list(string)
  default     = []
}

variable "web_server_allowed_ips_for_ssh_rdp" {
  description = "List of IP addresses that have SSH or RDP access to the instance"
  type        = list(string)
  default     = []
}

variable "app_server_allowed_ips_for_winrm" {
  description = "List of IP addresses that have winrm access to the instance"
  type        = list(string)
  default     = []
}

variable "db_server_allowed_ips_for_winrm" {
  description = "List of IP addresses that have winrm access to the instance"
  type        = list(string)
  default     = []
}

variable "web_server_allowed_ips_for_winrm" {
  description = "List of IP addresses that have winrm access to the instance"
  type        = list(string)
  default     = []
}

variable "app_server_ec2_maintenance_window" {
  description = "The type of instance to start in app server layer"
  type        = string
  default     = "SUN_00"
}

variable "db_server_ec2_maintenance_window" {
  description = "The type of instance to start in database server layer"
  type        = string
  default     = "SUN_00"
}

variable "web_server_ec2_maintenance_window" {
  description = "The type of instance to start in web server layer"
  type        = string
  default     = "SUN_00"
}

variable "ansible_secrets_parameter_name" {
  description = "Parameter store name for ansible secret"
  type        = string
  default     = "/ansible/secrets"
}

variable "ansible_secrets_parameter_policy_name" {
  description = "IAM Policy name for access to Parameter store for ansible secret"
  type        = string
  default     = "ansible-secrets-parameter-store-policy"
}

variable "ansible_token" {
  description = "Secrets for ansible configuration"
  type        = string
  default     = ""
}

variable "ansible_server_url" {
  description = "Ansible Server Url"
  type        = string
  default     = ""
}


variable "asg_config_ssm_documentname" {
  description = "SSM docuement name for asf configuration"
  type        = string
  default     = "AWS-RunRemoteScript"
}

variable "asg_config_powershell_script" {
  description = "ps filename in s3 bucket used to call ansible api"
  type        = string
  default     = "bootstrap.ps1"
}

variable "ansible_config_bucket_name" {
  description = "Ansible configuration bucket name."
  type        = string
  default     = ""
}


variable "ansible_bucket_policy_name" {
  description = "Name of iam policy used to access ansible bucket."
  type        = string
  default     = "ansible-configuration-s3-bucket-policy"
}

variable "domain_join_lambda_config" {
  description = "Lambda configurations for domain join"
  type        = map(string)
  default     = {}
}

variable "hostname_lambda_zip_filename" {
  description = "hostname lambda zip filename"
  type        = string
  default     = "hostname.zip"
}

variable "hostname_lambda_memory_size" {
  type        = number
  description = "Lambda memory size in mb"
  default     = 200
}

variable "hostname_lambda_timeout" {
  type        = number
  description = "Lambda timeout in seconds"
  default     = 50
}

variable "hostname_lambda_handler" {
  description = "lambda handler"
  type        = string
  default     = "hostname.lambda_handler"
}

variable "hostname_lambda_runtime" {
  description = "lambda runtime"
  type        = string
  default     = "python3.8"
}

variable "hostname_lambda_concurrent_executions" {
  type        = number
  description = "Reserved concurrency for hostname lambda"
  default     = 1
}

variable "service_account_secret" {
  description = "account secret (service account secret & artifcatory token)"
  type        = map(string)
  default     = {}
}

variable "cloudwatchagent_policy_arn" {
  description = "cloudwatch agent policy arn"
  type        = string
  default     = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

variable "ssm_policy_arn" {
  description = "ssm policy arn"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

variable "kms_arn_for_secret" {
  description = "CMK KMS arn for secret manager"
  type        = string
  default     = ""
}

variable "create_s3_logging_bucket" {
  description = "Create S3 logging bucket for S3 access audit"
  type        = bool
  default     = true
}

variable "external_s3_logging_bucket_arn" {
  description = "S3 external logging bucket arn for S3 access audit. This is mandatory when create_s3_logging_bucket is false"
  type        = string
  default     = ""
}

variable "artifactory_token" {
  description = "artifactory token"
  type        = string
  default     = ""
}

variable "secret_manager_arns" {
  description = "List of secret manager arns whose read policies to be assigned to the EC2 Instance"
  type        = list(string)
  default     = []
}