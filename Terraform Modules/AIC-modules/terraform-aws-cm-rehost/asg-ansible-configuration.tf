
resource "aws_ssm_parameter" "ansible_token" {
  count       = (var.app_server_use_ansible_configuration || var.web_server_use_ansible_configuration || var.db_server_use_ansible_configuration || var.asg_app_server_use_ansible_configuration || var.asg_web_server_use_ansible_configuration) ? 1 : 0
  name        = var.ansible_secrets_parameter_name
  description = "Ansible api secrets"
  type        = "SecureString"
  value       = var.ansible_token
  overwrite   = true
  tags = local.common_tags
}
####################################### extravar aws_ssm_parameter ###########################################
resource "aws_ssm_parameter" "ansible_asg_webserver_extravar" {
  count       = var.asg_web_server_use_ansible_configuration && var.asg_web_server_ansible_extra_var != "" ? 1 : 0
  name        = var.asg_web_server_ansible_extra_var_parameter_name
  description = "ASG Ansible webserver extra variable"
  type        = "SecureString"
  value       = var.asg_web_server_ansible_extra_var
  overwrite   = true
  tags = local.common_tags
}

resource "aws_ssm_parameter" "ansible_asg_appserver_extravar" {
  count       = var.asg_app_server_use_ansible_configuration && var.asg_app_server_ansible_extra_var != "" ? 1 : 0
  name        = var.asg_app_server_ansible_extra_var_parameter_name
  description = "ASG Ansible appserver extra variable"
  type        = "SecureString"
  value       = var.asg_app_server_ansible_extra_var
  overwrite   = true
  tags = local.common_tags
}

resource "aws_ssm_parameter" "ansible_webserver_extravar" {
  count       = var.web_server_use_ansible_configuration && var.web_server_ansible_extra_var != "" ? 1 : 0
  name        = var.web_server_ansible_extra_var_parameter_name
  description = "Ansible webserver extra variable"
  type        = "SecureString"
  value       = var.web_server_ansible_extra_var
  overwrite   = true
  tags = local.common_tags
}

resource "aws_ssm_parameter" "ansible_dbserver_extravar" {
  count       = var.db_server_use_ansible_configuration && var.db_server_ansible_extra_var != "" ? 1 : 0
  name        = var.db_server_ansible_extra_var_parameter_name
  description = "Ansible dbserver extra variable"
  type        = "SecureString"
  value       = var.db_server_ansible_extra_var
  overwrite   = true
  tags = local.common_tags
}

resource "aws_ssm_parameter" "ansible_appserver_extravar" {
  count       = var.app_server_use_ansible_configuration && var.app_server_ansible_extra_var != "" ? 1 : 0
  name        = var.app_server_ansible_extra_var_parameter_name
  description = "Ansible appserver extra variable"
  type        = "SecureString"
  value       = var.app_server_ansible_extra_var
  overwrite   = true
  tags = local.common_tags
}
###############################################################################
locals {
  s3_tags = {
    ProductCode = var.product_code,
    Environment = var.env }
}

// S3 logging bucket
module "s3-bucket-log" {
  count   = var.create_s3_logging_bucket ? 1 : 0
  source  = "ptfe-crx5x8zy.deeptpe.pmicloud.xyz/core-prd/s3/aws"
  version = "1.1.2"
  bucket  = "${var.product_code}-${var.env}-s3-log-bucket"
  acl     = "log-delivery-write"

  tags = merge(local.common_tags, {
    Name = "${var.product_code}-${var.env}-s3-log-bucket"
  })

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}


// S3 Bucket for script file
resource "aws_s3_bucket" "s3_config_script_bucket" {
  // Bastion bucket containing keys and scripts
  count  = (var.app_server_use_ansible_configuration || var.web_server_use_ansible_configuration || var.db_server_use_ansible_configuration || var.asg_app_server_use_ansible_configuration || var.asg_web_server_use_ansible_configuration) ? 1 : 0
  bucket = var.ansible_config_bucket_name
  acl    = "private"
  #checkov:skip=CKV_AWS_18:Ensure the S3 bucket has access logging enabled
  #checkov:skip=CKV_AWS_21:Ensure all data stored in the S3 bucket have versioning enabled

  logging {
    target_bucket = var.create_s3_logging_bucket ? module.s3-bucket-log[0].this_s3_bucket_id : var.external_s3_logging_bucket_arn
    target_prefix = "s3-bucket-log/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = false
  }

  tags = merge(local.common_tags, {
    Name = var.ansible_config_bucket_name
  })
}

resource "aws_s3_bucket_object" "ansible_config_script_windows" {
  count  = (var.app_server_use_ansible_configuration || var.web_server_use_ansible_configuration || var.db_server_use_ansible_configuration || var.asg_app_server_use_ansible_configuration || var.asg_web_server_use_ansible_configuration) ? 1 : 0
  bucket = aws_s3_bucket.s3_config_script_bucket[0].id
  key    = var.asg_config_powershell_script
  source = "${path.module}/bootstrapscript/bootstrap.ps1"
  etag   = filemd5("${path.module}/bootstrapscript/bootstrap.ps1")
}

locals {
  source_info = {
    path = (var.app_server_use_ansible_configuration || var.web_server_use_ansible_configuration || var.db_server_use_ansible_configuration || var.asg_app_server_use_ansible_configuration || var.asg_web_server_use_ansible_configuration) ? "https://s3.amazonaws.com/${aws_s3_bucket.s3_config_script_bucket[0].id}/${var.asg_config_powershell_script}" : ""
  }
}
################################# SSM Association ############################################ 
resource "aws_ssm_association" "ansible_asg_webserver_association" {
  count            = var.asg_web_server_use_ansible_configuration ? 1 : 0
  name             = var.asg_config_ssm_documentname
  association_name = var.asg_web_server_association_name

  targets {
    key    = "tag:Tier"
    values = [var.asg_web_server_tier_tag_value]
  }

  parameters = {
    sourceType  = "S3"
    sourceInfo  = jsonencode(local.source_info)
    commandLine = "${var.asg_config_powershell_script} \"${var.ansible_server_url}\"  \"${var.asg_web_server_ansible_jobtemplatename}\" \"${var.ansible_secrets_parameter_name}\" \"${var.asg_web_server_ansible_extra_var_parameter_name}\""
  }
}

resource "aws_ssm_association" "ansible_asg_appserver_association" {
  count            = var.asg_app_server_use_ansible_configuration ? 1 : 0
  name             = var.asg_config_ssm_documentname
  association_name = var.asg_app_server_association_name

  targets {
    key    = "tag:Tier"
    values = [var.asg_app_server_tier_tag_value]
  }

  parameters = {
    sourceType  = "S3"
    sourceInfo  = jsonencode(local.source_info)
    commandLine = "${var.asg_config_powershell_script} \"${var.ansible_server_url}\"  \"${var.asg_app_server_ansible_jobtemplatename}\" \"${var.ansible_secrets_parameter_name}\" \"${var.asg_app_server_ansible_extra_var_parameter_name}\""
  }
}

resource "aws_ssm_association" "ansible_webserver_association" {
  count            = var.web_server_use_ansible_configuration ? 1 : 0
  name             = var.asg_config_ssm_documentname
  association_name = var.web_server_association_name

  targets {
    key    = "tag:Tier"
    values = [var.web_server_tier_tag_value]
  }

  parameters = {
    sourceType  = "S3"
    sourceInfo  = jsonencode(local.source_info)
    commandLine = "${var.asg_config_powershell_script} \"${var.ansible_server_url}\"  \"${var.web_server_ansible_jobtemplatename}\" \"${var.ansible_secrets_parameter_name}\" \"${var.web_server_ansible_extra_var_parameter_name}\""
  }
}

resource "aws_ssm_association" "ansible_appserver_association" {
  count            = var.app_server_use_ansible_configuration ? 1 : 0
  name             = var.asg_config_ssm_documentname
  association_name = var.app_server_association_name

  targets {
    key    = "tag:Tier"
    values = [var.app_server_tier_tag_value]
  }

  parameters = {
    sourceType  = "S3"
    sourceInfo  = jsonencode(local.source_info)
    commandLine = "${var.asg_config_powershell_script} \"${var.ansible_server_url}\"  \"${var.app_server_ansible_jobtemplatename}\" \"${var.ansible_secrets_parameter_name}\" \"${var.app_server_ansible_extra_var_parameter_name}\""
  }
}

resource "aws_ssm_association" "ansible_dbserver_association" {
  count            = var.db_server_use_ansible_configuration ? 1 : 0
  name             = var.asg_config_ssm_documentname
  association_name = var.db_server_association_name

  targets {
    key    = "tag:Tier"
    values = [var.db_server_tier_tag_value]
  }

  parameters = {
    sourceType  = "S3"
    sourceInfo  = jsonencode(local.source_info)
    commandLine = "${var.asg_config_powershell_script} \"${var.ansible_server_url}\"  \"${var.db_server_ansible_jobtemplatename}\" \"${var.ansible_secrets_parameter_name}\" \"${var.db_server_ansible_extra_var_parameter_name}\""
  }
}
