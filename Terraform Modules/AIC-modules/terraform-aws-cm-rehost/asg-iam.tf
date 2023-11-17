data "aws_caller_identity" "current" {}

data "aws_region" "region" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "ansible_bucket_policy_document" {
  count = (var.app_server_use_ansible_configuration || var.web_server_use_ansible_configuration || var.db_server_use_ansible_configuration || var.asg_app_server_use_ansible_configuration || var.asg_web_server_use_ansible_configuration) ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.ansible_config_bucket_name}"]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:*Object"]
    resources = ["arn:aws:s3:::${var.ansible_config_bucket_name}/*"]
  }
}

data "aws_iam_policy_document" "ansible_token" {
  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters"]
    resources = ["arn:aws:execute-api:${data.aws_region.region.name}:${data.aws_caller_identity.current.account_id}:parameter${var.ansible_secrets_parameter_name}"]
  }
}

data "aws_iam_policy_document" "asg_appserver_extravar_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters"]
    resources = ["arn:aws:execute-api:${data.aws_region.region.name}:${data.aws_caller_identity.current.account_id}:parameter${var.asg_app_server_ansible_extra_var_parameter_name}"]
  }
}

data "aws_iam_policy_document" "asg_webserver_extravar_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters"]
    resources = ["arn:aws:execute-api:${data.aws_region.region.name}:${data.aws_caller_identity.current.account_id}:parameter${var.asg_web_server_ansible_extra_var_parameter_name}"]
  }
}

resource "aws_iam_policy" "ansible_bucket_policy" {
  count  = (var.app_server_use_ansible_configuration || var.web_server_use_ansible_configuration || var.db_server_use_ansible_configuration || var.asg_app_server_use_ansible_configuration || var.asg_web_server_use_ansible_configuration) ? 1 : 0
  name   = var.ansible_bucket_policy_name
  policy = data.aws_iam_policy_document.ansible_bucket_policy_document[count.index].json
  tags = local.common_tags
}

resource "aws_iam_policy" "ansible_token_policy" {
  count  = (var.app_server_use_ansible_configuration || var.web_server_use_ansible_configuration || var.db_server_use_ansible_configuration || var.asg_app_server_use_ansible_configuration || var.asg_web_server_use_ansible_configuration) ? 1 : 0
  name   = var.ansible_secrets_parameter_policy_name
  policy = data.aws_iam_policy_document.ansible_token.json
  tags = local.common_tags
}

//asg web server iam configuration
resource "aws_iam_policy" "asg_web_server_ansible_extravar_policy" {
  count  = var.asg_web_server_count >= 1 && var.asg_web_server_use_ansible_configuration && var.asg_web_server_ansible_extra_var != "" ? 1 : 0
  name   = var.asg_web_server_ansible_extra_var_parameter_policy_name
  policy = data.aws_iam_policy_document.asg_webserver_extravar_policy_document.json
  tags = local.common_tags
}

resource "aws_iam_role" "asg_web_server_iam_role" {
  count              = var.asg_web_server_count >= 1 ? 1 : 0
  name_prefix        = "${var.web_server_name}-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "asg_web_server_ssm_policy_attachment" {
  count      = var.asg_web_server_count >= 1 ? 1 : 0
  role       = aws_iam_role.asg_web_server_iam_role[count.index].name
  policy_arn = var.ssm_policy_arn
}

resource "aws_iam_role_policy_attachment" "asg_web_server_cloudwatchagent_policy_attachment" {
  count      = var.asg_web_server_count >= 1 ? 1 : 0
  role       = aws_iam_role.asg_web_server_iam_role[count.index].name
  policy_arn = var.cloudwatchagent_policy_arn
}

resource "aws_iam_role_policy_attachment" "asg_web_server_ansible_bucket_policy_attachment" {
  count      = var.asg_web_server_use_ansible_configuration && var.asg_web_server_count >= 1 ? 1 : 0
  role       = aws_iam_role.asg_web_server_iam_role[count.index].name
  policy_arn = aws_iam_policy.ansible_bucket_policy[count.index].arn
}

resource "aws_iam_role_policy_attachment" "asg_web_server_ansible_extravar_policy_attachment" {
  count      = var.asg_web_server_count >= 1 && var.asg_web_server_use_ansible_configuration && var.asg_web_server_ansible_extra_var != "" ? 1 : 0
  role       = aws_iam_role.asg_web_server_iam_role[count.index].name
  policy_arn = aws_iam_policy.asg_web_server_ansible_extravar_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "asg_web_server_ansible_token_policy_attachment" {
  count      = var.asg_web_server_count >= 1 && var.asg_web_server_use_ansible_configuration ? 1 : 0
  role       = aws_iam_role.asg_web_server_iam_role[count.index].name
  policy_arn = aws_iam_policy.ansible_token_policy[0].arn
}

resource "aws_iam_instance_profile" "asg_web_server_ec2_instance_profile" {
  count = var.asg_web_server_count >= 1 ? 1 : 0
  role  = aws_iam_role.asg_web_server_iam_role[count.index].name
  name  = aws_iam_role.asg_web_server_iam_role[count.index].name
}

resource "aws_iam_role_policy_attachment" "asg_web_server_iam_custom_role_attachment" {
  for_each   = var.asg_web_server_iam_policy_arn
  policy_arn = each.value
  role       = aws_iam_role.asg_web_server_iam_role[0].name
}

resource "aws_iam_role_policy_attachment" "asg_web_server_lambda_invoke_policy_attachment" {
  count      = var.asg_web_server_count >= 1 && var.asg_web_server_join_domain ? 1 : 0
  role       = aws_iam_role.asg_web_server_iam_role[count.index].name
  policy_arn = aws_iam_policy.domainjoin_lambda_invoke_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "asg_web_server_secret_read_policy_attachment" {
  count      = var.asg_web_server_count >= 1 && length(local.secret_manager_arn_list) > 0 ? 1 : 0
  role       = aws_iam_role.asg_web_server_iam_role[count.index].name
  policy_arn = aws_iam_policy.secret_manager_read_policy[0].arn
}

//asg app server iam configuration

resource "aws_iam_policy" "asg_app_server_ansible_extravar_policy" {
  count  = var.asg_app_server_count >= 1 && var.asg_app_server_use_ansible_configuration && var.asg_app_server_ansible_extra_var != "" ? 1 : 0
  name   = var.asg_app_server_ansible_extra_var_parameter_policy_name
  policy = data.aws_iam_policy_document.asg_appserver_extravar_policy_document.json
  tags = local.common_tags
}

resource "aws_iam_role" "asg_app_server_iam_role" {
  count              = var.asg_app_server_count >= 1 ? 1 : 0
  name_prefix        = "${var.app_server_name}-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "asg_app_server_ssm_policy_attachment" {
  count      = var.asg_app_server_count >= 1 ? 1 : 0
  role       = aws_iam_role.asg_app_server_iam_role[count.index].name
  policy_arn = var.ssm_policy_arn
}

resource "aws_iam_role_policy_attachment" "asg_app_server_cloudwatchagent_policy_attachment" {
  count      = var.asg_app_server_count >= 1 ? 1 : 0
  role       = aws_iam_role.asg_app_server_iam_role[count.index].name
  policy_arn = var.cloudwatchagent_policy_arn
}

resource "aws_iam_role_policy_attachment" "asg_app_server_ansible_bucket_policy_attachment" {
  count      = var.asg_app_server_use_ansible_configuration && var.asg_app_server_count >= 1 ? 1 : 0
  role       = aws_iam_role.asg_app_server_iam_role[count.index].name
  policy_arn = aws_iam_policy.ansible_bucket_policy[count.index].arn
}

resource "aws_iam_role_policy_attachment" "asg_app_server_ansible_extravar_policy_attachment" {
  count      = var.asg_app_server_count >= 1 && var.asg_app_server_use_ansible_configuration && var.asg_app_server_ansible_extra_var != "" ? 1 : 0
  role       = aws_iam_role.asg_app_server_iam_role[count.index].name
  policy_arn = aws_iam_policy.asg_app_server_ansible_extravar_policy[0].arn
}

resource "aws_iam_instance_profile" "asg_app_server_ec2_instance_profile" {
  count = var.asg_app_server_count >= 1 ? 1 : 0
  role  = aws_iam_role.asg_app_server_iam_role[count.index].name
  name  = aws_iam_role.asg_app_server_iam_role[count.index].name
}

resource "aws_iam_role_policy_attachment" "asg_app_server_iam_custom_role_attachment" {
  for_each   = var.asg_app_server_iam_policy_arn
  policy_arn = each.value
  role       = aws_iam_role.asg_app_server_iam_role[0].name
}

resource "aws_iam_role_policy_attachment" "asg_app_server_lambda_invoke_policy_attachment" {
  count      = var.asg_app_server_count >= 1 && var.asg_app_server_join_domain && length(var.domain_join_lambda_config) > 0 ? 1 : 0
  role       = aws_iam_role.asg_app_server_iam_role[count.index].name
  policy_arn = aws_iam_policy.domainjoin_lambda_invoke_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "asg_app_server_secret_read_policy_attachment" {
  count      = var.asg_app_server_count >= 1 && length(local.secret_manager_arn_list) > 0 ? 1 : 0
  role       = aws_iam_role.asg_app_server_iam_role[count.index].name
  policy_arn = aws_iam_policy.secret_manager_read_policy[0].arn
}

