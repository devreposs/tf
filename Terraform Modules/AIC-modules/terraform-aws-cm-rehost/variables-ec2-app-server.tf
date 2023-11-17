# variables for ec2-module for app server layer
variable "app_server_ec2_instance_count" {
  description = "Number of instances to launch in app server layer"
  type        = number
  default     = 0
}

variable "app_server_ec2_backup_plan" {
  description = "A tag for back up plan that needs to be specified in app server layer"
  type        = string
  default     = "default"
}

variable "app_server_ec2_root_volume_size" {
  description = "Volume size for the root block device of the instance in app server layer"
  type        = string
  default     = ""
}

variable "app_server_ec2_iam_policy_arn" {
  description = "List of policies to be assigned to the EC2 Instance in app server layer"
  type        = map(string)
  default     = {}
}

variable "app_server_ec2_ebs_volume_device" {
  description = "EBS volumes to be created that needs to be attached to the instance"
  type        = map(map(string))
  default     = { device1 = { device_name = "/dev/sdf", volume_size = "20" } }
}

variable "app_server_auto_recovery_alarm" {
  description = "Create auto recovery alarm for service instances"
  type        = bool
  default     = false
}

variable "app_server_instance_type" {
  description = "The type of instance to start in service layer"
  type        = string
  default     = "t2.micro"
}

variable "app_server_platform" {
  description = "Name of AMI to use for the instance, give windows or linux as a value in service layer"
  type        = string
  default     = "windows"
}

variable "app_server_os" {
  description = "Name of AMI to use for the instance, give windows or linux as a value in service layer"
  type        = string
  default     = "windows2019"
}

variable "app_server_user_data" {
  description = "Contents of EC2 user-data"
  type        = string
  default     = ""
}

variable "app_server_ec2_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "app_server_ec2_volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

variable "additional_app_server_security_groups" {
  description = "A list of additional security group IDs to assign to the launch configuration"
  type        = list(string)
  default     = []
}

variable "app_server_join_domain" {
  description = "whether appserver will join PMINTL.NET domain"
  type        = bool
  default     = false
}

variable "app_server_tier_tag_value" {
  description = "Tier tag value for appserver"
  type        = string
  default     = "appserver"
}

variable "app_server_use_ansible_configuration" {
  description = "Allows set up to call ansible jobtempalte from SSM association"
  type        = bool
  default     = false
}

variable "app_server_ansible_extra_var_parameter_name" {
  description = "Ansible appserver extra var parameter name"
  type        = string
  default     = "/ansible/appserver/extravar"
}

variable "app_server_ansible_extra_var_parameter_policy_name" {
  description = "Ansible appserver extra var parameter name"
  type        = string
  default     = "appserver-ansible-extravar-parameter-store-policy"
}

variable "app_server_ansible_extra_var" {
  description = "Ansible webserver extravar"
  type        = string
  default     = ""
}

variable "app_server_ansible_jobtemplatename" {
  description = "Ansible appserver jobtemplate name pmi-app-<project_code>-<environment>-ansible-job-template"
  type        = string
  default     = ""
}

variable "app_server_association_name" {
  description = "SSM Association name for appserver"
  type        = string
  default     = "app-server-association-ansible-config"
}

variable "app_server_attach_db_server_security_group" {
  description = "Attach db server client security group to instance"
  type        = bool
  default     = false
}
