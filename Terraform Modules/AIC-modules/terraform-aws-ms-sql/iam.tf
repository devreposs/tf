data "aws_region" "default" {}

resource "aws_iam_role" "default" {
  name_prefix        = "${var.name}-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

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

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_server_policy" {
  role       = aws_iam_role.default.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "api_gateway_invoke_full_access" {
  role       = aws_iam_role.default.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.default.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy_document" "deny_create_log_group" {
  statement {
    effect = "Deny"
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "deny_create_log_group" {
  policy = data.aws_iam_policy_document.deny_create_log_group.json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "deny_create_log_group" {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.deny_create_log_group.arn
}

resource "aws_iam_role_policy_attachment" "ec2_iam_custom_role_attachment" {
  for_each   = var.iam_policy_arn
  policy_arn = each.value
  role       = aws_iam_role.default.name
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  role = aws_iam_role.default.name
  name = aws_iam_role.default.name
  tags = var.tags
}
