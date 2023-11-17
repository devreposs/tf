# Additional security group for web layer
resource "aws_security_group" "web_server_additional_security_group" {
  description = "web server security group"
  vpc_id      = data.terraform_remote_state.app_baseline.outputs.vpc_id_primary
  name        = "additional-web-security-group"
  tags = {
    Name = "additional-web-security-group"
  }
}

# Security group ingress rule to the new web security group
resource "aws_security_group_rule" "web_server_instance_additional_http" {
  description       = "web  server security group rule"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = lookup(var.web_ingress_cidr, var.env)
  security_group_id = aws_security_group.web_server_additional_security_group.id
}

# Security group ingress rule to the new web security group
resource "aws_security_group_rule" "web_server_instance_additional_https" {
  description       = "web  server security group rule"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = lookup(var.web_ingress_cidr, var.env)
  security_group_id = aws_security_group.web_server_additional_security_group.id
}

# Additional security group for app layer
resource "aws_security_group" "app_server_additional_security_group" {
  description = "app server security group"
  vpc_id      = data.terraform_remote_state.app_baseline.outputs.vpc_id_primary
  name        = "additional-app-security-group"
  tags = {
    Name = "additional-app-security-group"
  }
}

# Additional security group ingress rule to the existing app security group
resource "aws_security_group_rule" "app_server_instance_additional" {
  description              = "app server security group rule"
  type                     = "ingress"
  from_port                = lookup(var.application_port, var.env)
  to_port                  = lookup(var.application_port, var.env)
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_server_additional_security_group.id
  security_group_id        = aws_security_group.app_server_additional_security_group.id
}

# Additional security group for db layer
resource "aws_security_group" "db_server_additional_security_group" {
  description = "db server security group"
  vpc_id      = data.terraform_remote_state.app_baseline.outputs.vpc_id_primary
  name        = "additional-db-security-group"
  tags = {
    Name = "additional-db-security-group"
  }
}

# Additional security group ingress rule to the existing database security group
resource "aws_security_group_rule" "db_server_instance_additional_1433_1" {
  description              = "db server security group rule"
  type                     = "ingress"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_server_additional_security_group.id
  security_group_id        = aws_security_group.db_server_additional_security_group.id
}

# Additional security group ingress rule to the existing database security group
resource "aws_security_group_rule" "db_server_instance_additional_1433_2" {
  description              = "db server security group rule"
  type                     = "ingress"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_server_additional_security_group.id
  security_group_id        = aws_security_group.db_server_additional_security_group.id
}
