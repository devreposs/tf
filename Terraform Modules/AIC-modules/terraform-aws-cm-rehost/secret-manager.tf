resource "aws_secretsmanager_secret" "artifactory_secret" {
  count                   = length(var.artifactory_token) > 0 ? 1 : 0
  name                    = "${var.product_code}-${var.env}-artifactory-secrets"
  recovery_window_in_days = 0
  kms_key_id              = var.kms_arn_for_secret
  tags = local.common_tags
}
resource "aws_secretsmanager_secret_version" "artifactory_secret_version" {
  count     = length(var.artifactory_token) > 0 ? 1 : 0
  secret_id = aws_secretsmanager_secret.artifactory_secret[0].id
  secret_string = jsonencode(
    {
      "token" = var.artifactory_token
    }
  )
}
##################################################################################
data "aws_iam_policy_document" "secret_manager_read_policy_document" {
  count = length(local.secret_manager_arn_list) > 0 ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["kms:decrypt"]
    resources = [var.kms_arn_for_secret]
  }
  statement {
    effect = "Allow"
    actions = ["secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
    "secretsmanager:ListSecretVersionIds"]
    resources = [for arn in local.secret_manager_arn_list :
      arn
    ]
  }
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:ListSecrets"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "secret_manager_read_policy" {
  count       = length(local.secret_manager_arn_list) > 0 ? 1 : 0
  name_prefix = "${var.product_code}-${var.env}-secret-read-policy"
  policy      = data.aws_iam_policy_document.secret_manager_read_policy_document[count.index].json
  tags = local.common_tags
}
