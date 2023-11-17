# Security group for asg web server
resource "aws_security_group" "asg_web_server_security_group" {
  count       = var.asg_web_server_count > 0 ? 1 : 0
  description = "asg web server security group"
  vpc_id      = var.vpc_id
  name        = "${var.web_server_name}-asg-${var.web_server_platform}"
  tags = merge( local.common_tags , {
    Name = "${var.web_server_name}-asg-${var.web_server_platform}"
  })
}

resource "aws_security_group_rule" "asg_web_server_windows_rdp" {
  count             = (var.asg_web_server_count > 0 && var.asg_web_server_platform == "windows") ? 1 : 0
  description       = "asg web server security group rule"
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.web_server_allowed_ips_for_ssh_rdp)
  security_group_id = aws_security_group.asg_web_server_security_group[0].id
}

resource "aws_security_group_rule" "asg_web_server_linux_ssh" {
  count             = (var.asg_web_server_count > 0 && var.asg_web_server_platform == "linux") ? 1 : 0
  description       = "asg web server security group rule"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.web_server_allowed_ips_for_ssh_rdp)
  security_group_id = aws_security_group.asg_web_server_security_group[0].id
}

resource "aws_security_group_rule" "asg_web_server_winrm_http" {
  count             = (var.asg_web_server_count > 0 && var.asg_web_server_platform == "windows") ? 1 : 0
  description       = "asg web server security group rule"
  type              = "ingress"
  from_port         = 5985
  to_port           = 5985
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.web_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.asg_web_server_security_group[0].id
}

resource "aws_security_group_rule" "asg_web_server_winrm_https" {
  count             = (var.asg_web_server_count > 0 && var.asg_web_server_platform == "windows") ? 1 : 0
  description       = "asg web server security group rule"
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.web_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.asg_web_server_security_group[0].id
}

resource "aws_security_group_rule" "asg_web_server_allow_all" {
  count             = var.asg_web_server_count > 0 ? 1 : 0
  description       = "asg web server security group rule"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  security_group_id = aws_security_group.asg_web_server_security_group[0].id
}

# Security group for asg app server
resource "aws_security_group" "asg_app_server_security_group" {
  count       = var.asg_app_server_count > 0 ? 1 : 0
  description = "asg app server security group"
  vpc_id      = var.vpc_id
  name        = "${var.app_server_name}-asg-${var.app_server_platform}"
  tags = merge( local.common_tags ,{
    Name = "${var.app_server_name}-asg-${var.app_server_platform}"
  })
}

resource "aws_security_group_rule" "asg_app_server_windows_rdp" {
  count             = (var.asg_app_server_count > 0 && var.asg_app_server_platform == "windows") ? 1 : 0
  description       = "asg app server security group rule"
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.app_server_allowed_ips_for_ssh_rdp)
  security_group_id = aws_security_group.asg_app_server_security_group[0].id
}

resource "aws_security_group_rule" "asg_app_server_linux_ssh" {
  count             = (var.asg_app_server_count > 0 && var.asg_app_server_platform == "linux") ? 1 : 0
  description       = "asg app server security group rule"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.app_server_allowed_ips_for_ssh_rdp)
  security_group_id = aws_security_group.asg_app_server_security_group[0].id
}

resource "aws_security_group_rule" "asg_app_server_winrm_http" {
  count             = (var.asg_app_server_count > 0 && var.asg_app_server_platform == "windows") ? 1 : 0
  description       = "asg app server security group rule"
  type              = "ingress"
  from_port         = 5985
  to_port           = 5985
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.app_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.asg_app_server_security_group[0].id
}

resource "aws_security_group_rule" "asg_app_server_winrm_https" {
  count             = (var.asg_app_server_count > 0 && var.asg_app_server_platform == "windows") ? 1 : 0
  description       = "asg app server security group rule"
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.app_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.asg_app_server_security_group[0].id
}

resource "aws_security_group_rule" "asg_app_server_allow_all" {
  count             = var.asg_app_server_count > 0 ? 1 : 0
  description       = "asg app server security group rule"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  security_group_id = aws_security_group.asg_app_server_security_group[0].id
}
/*
# Security group for web server layer ec2 instances
resource "aws_security_group" "web_server_instance_security_group" {
  count       = var.web_server_ec2_instance_count > 0 && var.web_server_platform == "windows" ? 1 : 0
  description = "web server security group"
  vpc_id      = var.vpc_id
  name        = "${var.web_server_name}-instance-${var.web_server_platform}"
  tags = merge( local.common_tags ,{
    Name = "${var.web_server_name}-instance-${var.web_server_platform}"
  })
}

resource "aws_security_group_rule" "web_server_instance_winrm_http" {
  count             = (var.web_server_ec2_instance_count > 0 && var.web_server_platform == "windows") ? 1 : 0
  description       = "web server security group rule"
  type              = "ingress"
  from_port         = 5985
  to_port           = 5985
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.web_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.web_server_instance_security_group[0].id
}

resource "aws_security_group_rule" "web_server_instance_winrm_https" {
  count             = (var.web_server_ec2_instance_count > 0 && var.web_server_platform == "windows") ? 1 : 0
  description       = "web server security group rule"
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.web_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.web_server_instance_security_group[0].id
}

resource "aws_security_group_rule" "web_server_instance_allow_all" {
  count             = var.web_server_ec2_instance_count > 0 && var.web_server_platform == "windows" ? 1 : 0
  description       = "web server security group rule"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  security_group_id = aws_security_group.web_server_instance_security_group[0].id
}

# Security group for app server layer ec2 instances
resource "aws_security_group" "app_server_instance_security_group" {
  count       = var.app_server_ec2_instance_count > 0 && var.app_server_platform == "windows" ? 1 : 0
  description = "app server security group"
  vpc_id      = var.vpc_id
  name        = "${var.app_server_name}-instance-${var.app_server_platform}"
  tags = merge( local.common_tags ,{
    Name = "${var.app_server_name}-instance-${var.app_server_platform}"
  })
}

resource "aws_security_group_rule" "app_server_instance_winrm_http" {
  count             = (var.app_server_ec2_instance_count > 0 && var.app_server_platform == "windows") ? 1 : 0
  description       = "app server security group rule"
  type              = "ingress"
  from_port         = 5985
  to_port           = 5985
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.app_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.app_server_instance_security_group[0].id
}

resource "aws_security_group_rule" "app_server_instance_winrm_https" {
  count             = (var.app_server_ec2_instance_count > 0 && var.app_server_platform == "windows") ? 1 : 0
  description       = "app server security group rule"
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.app_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.app_server_instance_security_group[0].id
}

resource "aws_security_group_rule" "app_server_instance_allow_all" {
  count             = var.app_server_ec2_instance_count > 0 && var.app_server_platform == "windows" ? 1 : 0
  description       = "app server security group rule"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  security_group_id = aws_security_group.app_server_instance_security_group[0].id
}

# Security group for db server layer ec2 instances
resource "aws_security_group" "db_server_instance_security_group" {
  count       = var.db_server_ec2_instance_count > 0 ? 1 : 0
  description = "db server security group"
  vpc_id      = var.vpc_id
  name        = "${var.db_server_name}-instance-windows"
  tags = merge( local.common_tags ,{
    Name = "${var.db_server_name}-instance-windows"
  })
}

resource "aws_security_group_rule" "db_server_instance_winrm_http" {
  count             = (var.db_server_ec2_instance_count > 0) ? 1 : 0
  description       = "db server security group rule"
  type              = "ingress"
  from_port         = 5985
  to_port           = 5985
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.db_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.db_server_instance_security_group[0].id
}

resource "aws_security_group_rule" "db_server_instance_winrm_https" {
  count             = (var.db_server_ec2_instance_count > 0) ? 1 : 0
  description       = "db server security group rule"
  type              = "ingress"
  from_port         = 5986
  to_port           = 5986
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.db_server_allowed_ips_for_winrm)
  security_group_id = aws_security_group.db_server_instance_security_group[0].id
}

resource "aws_security_group_rule" "db_server_instance_allow_all" {
  count             = var.db_server_ec2_instance_count > 0 ? 1 : 0
  description       = "db server security group rule"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  security_group_id = aws_security_group.db_server_instance_security_group[0].id
}
*/