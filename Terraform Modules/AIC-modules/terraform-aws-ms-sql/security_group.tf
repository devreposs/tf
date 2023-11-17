data "aws_subnet" "instance_subnet" {
  id = var.subnet_id
}

data "aws_vpc" "instance_vpc" {
  id = data.aws_subnet.instance_subnet.vpc_id
}

resource "aws_security_group" "default" {
  vpc_id      = data.aws_subnet.instance_subnet.vpc_id
  name_prefix = var.ec2_security_group_prefix
  tags = merge(
    local.tags,
    {
      Name = "${var.ec2_security_group_prefix}-sql${var.sql_version}-${var.sql_edition}"
    }
  )
}

resource "aws_security_group_rule" "windows_rdp_access" {
  type              = "ingress"
  from_port         = 3389
  protocol          = "tcp"
  cidr_blocks       = concat([data.aws_vpc.instance_vpc.cidr_block], var.allowed_ips)
  security_group_id = aws_security_group.default.id
  to_port           = 3389
}


resource "aws_security_group_rule" "allow_all_egress" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.default.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group" "sg_ms_sql_clients" {
  name_prefix = "${var.name}_clients-"
  description = "MSS SQL Clients"
  vpc_id      = data.aws_subnet.instance_subnet.vpc_id
  tags = merge(
    local.tags,
    {
      "Name" = "${var.name}_clients"
    },
  )
  lifecycle {
    ignore_changes = [description]
  }
}


resource "aws_security_group" "sg_ms_sql_access" {
  name_prefix = "${var.name}_access-"
  description = "MS SQL Access rules"
  vpc_id      = data.aws_subnet.instance_subnet.vpc_id
  tags = merge(
    local.tags,
    {
      "Name" = "${var.name}_access"
    },
  )
}

resource "aws_security_group_rule" "ms_sql_ingress_dbport_clients" {
  // Allow access from clients
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_ms_sql_access.id
  source_security_group_id = aws_security_group.sg_ms_sql_clients.id
}
