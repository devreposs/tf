data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "domainjoin_lambda_policy_document" {
  statement {
    effect = "Allow"
    actions = ["ssm:DescribeParameters",
      "ssm:PutParameter",
      "ssm:GetParameters",
    "ssm:GetParameter"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "domainjoin_lambda_invoke_policy" {
  count = length(var.domain_join_lambda_config) > 0 ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = [aws_lambda_function.domain_join_lambda[count.index].arn]
  }
}


//IAM role for Lambda
resource "aws_iam_role" "domainjoin_lambda_iam_role" {
  count              = length(var.domain_join_lambda_config) > 0 ? 1 : 0
  name_prefix        = "${lookup(var.domain_join_lambda_config, "name", null)}-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  tags = local.common_tags
}

resource "aws_iam_policy" "domainjoin_lambda_parameter_access_policy" {
  count  = length(var.domain_join_lambda_config) > 0 ? 1 : 0
  name   = "${lookup(var.domain_join_lambda_config, "name", null)}-ssm-parameter-access"
  policy = data.aws_iam_policy_document.domainjoin_lambda_policy_document.json
  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "domainjoin_lambda_parameter_access_policy_attachment" {
  count      = length(var.domain_join_lambda_config) > 0 ? 1 : 0
  role       = aws_iam_role.domainjoin_lambda_iam_role[count.index].name
  policy_arn = aws_iam_policy.domainjoin_lambda_parameter_access_policy[count.index].arn
}

//Policies for instaces 
resource "aws_iam_policy" "domainjoin_lambda_invoke_policy" {
  count  = (length(var.domain_join_lambda_config) > 0 && (var.asg_app_server_join_domain || var.asg_web_server_join_domain || var.app_server_join_domain || var.db_server_join_domain || var.web_server_join_domain)) ? 1 : 0
  name   = "${lookup(var.domain_join_lambda_config, "name", null)}-invoke-policy"
  policy = data.aws_iam_policy_document.domainjoin_lambda_invoke_policy[count.index].json
  tags = local.common_tags
}


// service account secret
resource "aws_secretsmanager_secret" "account_secret" {
  count                   = length(var.service_account_secret) > 0 ? 1 : 0
  name                    = "${var.product_code}-${var.env}-service-account-secret"
  kms_key_id              = var.kms_arn_for_secret
  recovery_window_in_days = 0
  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "account_secret_version" {
  count         = length(var.service_account_secret) > 0 ? 1 : 0
  secret_id     = aws_secretsmanager_secret.account_secret[0].id
  secret_string = jsonencode(var.service_account_secret)
}

// lambda
data "archive_file" "hostname_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = var.hostname_lambda_zip_filename
}

resource "aws_lambda_function" "domain_join_lambda" {
  count                          = length(var.domain_join_lambda_config) > 0 ? 1 : 0
  filename                       = var.hostname_lambda_zip_filename
  source_code_hash               = data.archive_file.hostname_lambda_zip.output_base64sha256
  function_name                  = lookup(var.domain_join_lambda_config, "name", null)
  role                           = aws_iam_role.domainjoin_lambda_iam_role[0].arn
  handler                        = var.hostname_lambda_handler
  memory_size                    = var.hostname_lambda_memory_size
  timeout                        = var.hostname_lambda_timeout
  runtime                        = var.hostname_lambda_runtime
  reserved_concurrent_executions = var.hostname_lambda_concurrent_executions
  environment {
    variables = {
      "hostmaxlength"     = lookup(var.domain_join_lambda_config, "hostmaxlength", null)
      "hostnameprefix"    = lookup(var.domain_join_lambda_config, "hostnameprefix", null)
      "parameterstorekey" = lookup(var.domain_join_lambda_config, "parameterstorekey", null)
      "suffixlength"      = lookup(var.domain_join_lambda_config, "suffixlength", null)
    }
  }
  tags = local.common_tags
}
