locals {
  common_tags = {
    ProductCode               = var.product_code
    Environment               = upper(var.env)
  }
  ami_filter_list = {
    amazonlinux2 = "deep-std-amazonlinux2-*"
    centos7      = "deep-extra-centos7-*"
    ubuntu20     = "deep-extra-ubuntu-*"
    windows2016  = "deep-std-windowsserver2016-*"
    windows2019  = "deep-std-windowsserver2019-*"
    rhel8-sap    = "deep-extra-rhel8-sap-*"
  }
  asg_app_server_os       = var.asg_app_server_os == "" ? (var.asg_app_server_platform == "windows" ? "windows2016" : "amazonlinux2") : var.asg_app_server_os
  asg_app_server_platform = (var.asg_app_server_platform == "" && local.asg_app_server_os != "") ? (length(regexall("windows", local.asg_app_server_os)) > 0 ? "windows" : "linux") : var.asg_app_server_platform
  asg_web_server_os       = var.asg_web_server_os == "" ? (var.asg_web_server_platform == "windows" ? "windows2016" : "amazonlinux2") : var.asg_web_server_os
  asg_web_server_platform = (var.asg_web_server_platform == "" && local.asg_web_server_os != "") ? (length(regexall("windows", local.asg_web_server_os)) > 0 ? "windows" : "linux") : var.asg_web_server_platform
  app_server_ec2_iam_policy_arn_list = merge(var.app_server_ec2_iam_policy_arn,
    (((var.app_server_join_domain) && length(var.domain_join_lambda_config) > 0) ? { "domain_join_policy" = aws_iam_policy.domainjoin_lambda_invoke_policy[0].arn } : {}),
    ((var.app_server_ec2_instance_count >= 1 && var.app_server_use_ansible_configuration && var.app_server_ansible_extra_var != "") ?
    { "app_server_ansible_extravar_policy" = aws_iam_policy.app_server_ansible_extravar_policy[0].arn } : {}),
    ((var.app_server_use_ansible_configuration && var.app_server_ec2_instance_count >= 1) ?
      { "ansible_bucket_policy" = aws_iam_policy.ansible_bucket_policy[0].arn
    "ansible_token_policy" = aws_iam_policy.ansible_token_policy[0].arn } : {}),
  (length(local.secret_manager_arn_list) > 0 ? { "secret_manager_read_policy" = aws_iam_policy.secret_manager_read_policy[0].arn } : {}))
  web_server_ec2_iam_policy_arn_list = merge(var.web_server_ec2_iam_policy_arn,
    (((var.web_server_join_domain) && length(var.domain_join_lambda_config) > 0) ? { "domain_join_policy" = aws_iam_policy.domainjoin_lambda_invoke_policy[0].arn } : {}),
    ((var.web_server_ec2_instance_count >= 1 && var.web_server_use_ansible_configuration && var.web_server_ansible_extra_var != "") ?
    { "web_server_ansible_extravar_policy" = aws_iam_policy.web_server_ansible_extravar_policy[0].arn } : {}),
    ((var.web_server_use_ansible_configuration && var.web_server_ec2_instance_count >= 1) ?
      { "ansible_bucket_policy" = aws_iam_policy.ansible_bucket_policy[0].arn
    "ansible_token_policy" = aws_iam_policy.ansible_token_policy[0].arn } : {}),
  (length(local.secret_manager_arn_list) > 0 ? { "secret_manager_read_policy" = aws_iam_policy.secret_manager_read_policy[0].arn } : {}))
  db_server_ec2_iam_policy_arn_list = merge(var.db_server_ec2_iam_policy_arn,
    (((var.db_server_join_domain) && length(var.domain_join_lambda_config) > 0) ? { "domain_join_policy" = aws_iam_policy.domainjoin_lambda_invoke_policy[0].arn } : {}),
    ((var.db_server_ec2_instance_count >= 1 && var.db_server_use_ansible_configuration && var.db_server_ansible_extra_var != "") ?
    { "db_server_ansible_extravar_policy" = aws_iam_policy.db_server_ansible_extravar_policy[0].arn } : {}),
    ((var.db_server_use_ansible_configuration && var.db_server_ec2_instance_count >= 1) ?
      { "ansible_bucket_policy" = aws_iam_policy.ansible_bucket_policy[0].arn
    "ansible_token_policy" = aws_iam_policy.ansible_token_policy[0].arn } : {}),
  (length(local.secret_manager_arn_list) > 0 ? { "secret_manager_read_policy" = aws_iam_policy.secret_manager_read_policy[0].arn } : {}))
  secret_manager_arn_list = concat(var.secret_manager_arns,
    (length(var.service_account_secret) > 0 ? [aws_secretsmanager_secret.account_secret[0].arn] : []),
  (length(var.artifactory_token) > 0 ? [aws_secretsmanager_secret.artifactory_secret[0].arn] : []))
}
