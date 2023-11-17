variable "baseline_workspace_name" {
  description = "baseline workspace name"
  type        = string
}

variable "env" {
  description = "Environment for the EC2 Instance"
  type        = string
  default     = "dev"
}

variable "product_code" {
  description = "Unique identifier across the whole DEEP platform"
  type        = string
}

variable "app_server_name" {
  description = "Name to be used on all resources as prefix in application layer"
  type        = string
}

variable "db_server_name" {
  description = "Name to be used on all resources as prefix in db layer"
  type        = string
}

variable "web_server_name" {
  description = "Name to be used on all resources as prefix in web layer"
  type        = string
}

variable "asg_app_server_count" {
  description = "asg app server count"
  type        = number
  default     = 1
}

variable "asg_web_server_count" {
  description = "asg web server count"
  type        = number
  default     = 1
}

variable "app_server_ec2_instance_count" {
  description = "app server ec2 instance count"
  type        = number
  default     = 1
}

variable "db_server_ec2_instance_count" {
  description = "db server ec2 instance count"
  type        = number
  default     = 1
}

variable "web_server_ec2_instance_count" {
  description = "web server ec2 instance count"
  type        = number
  default     = 1
}

variable "asg_app_server_max_size" {
  description = "The maximum size of the auto scale group"
  type        = string
  default     = "1"
}

variable "asg_app_server_min_size" {
  description = "The minimum size of the auto scale group"
  type        = string
  default     = "1"
}

variable "asg_app_server_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = string
  default     = "1"
}

variable "asg_web_server_max_size" {
  description = "The maximum size of the auto scale group"
  type        = string
  default     = "1"
}

variable "asg_web_server_min_size" {
  description = "The minimum size of the auto scale group"
  type        = string
  default     = "1"
}

variable "asg_web_server_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = string
  default     = "1"
}