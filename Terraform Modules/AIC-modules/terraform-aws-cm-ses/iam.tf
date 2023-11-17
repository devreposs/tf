resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user" "this" {
  name = "ses-smtp-user.${var.product_code}-${var.environment}"
  tags = local.ses_tags
}

resource "aws_iam_group" "this" {
  name = "ses-smtp-group.${var.product_code}-${var.environment}"
  path = "/users/"
}


resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.this.name

  groups = [
    aws_iam_group.this.name,
  ]
}

resource "aws_iam_policy" "this" {
  name_prefix = "SES-"
  description = "SES USER GROUP POLICY"
  tags        = local.ses_tags
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": "*"
        }
    ]
}
 
EOF
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_ssm_parameter" "this_username" {
  name  = "/ses/${var.environment}/smtp_username"
  type  = "String"
  value = aws_iam_access_key.this.id
  tags  = local.ses_tags
}

resource "aws_ssm_parameter" "this_password" {
  name  = "/ses/${var.environment}/smtp_password"
  type  = "SecureString"
  value = aws_iam_access_key.this.ses_smtp_password_v4
  tags  = local.ses_tags
}
