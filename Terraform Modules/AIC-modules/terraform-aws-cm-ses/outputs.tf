output "ssm_user_path" {
  description = "Path for ssm username value"
  value       = aws_ssm_parameter.this_username.name
}

output "ssm_password_path" {
  description = "Path for ssm password value"
  value       = aws_ssm_parameter.this_password.name
}
