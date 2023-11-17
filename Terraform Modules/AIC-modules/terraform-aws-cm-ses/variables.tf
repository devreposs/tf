variable "ses_domain" {
  description = "domain for SES"
  type        = string
  default     = "eu-west-1.aws.pmicloud.biz"
}


variable "enable_verification" {
  description = "Enabling domain verification for SES"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment i.e. dev/qa/prd"
  type        = string
}

variable "product_code" {
  description = "Unique identifier across the whole DEEP platform"
  type        = string
}


variable "route53_acn_zone_id" {
  description = "Route53 public zone id from baseline"
  type        = string
}
