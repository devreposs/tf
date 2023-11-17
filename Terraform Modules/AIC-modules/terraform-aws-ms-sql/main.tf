locals {
  data_volume_name       = "/dev/sdb"
  log_volume_name        = "/dev/sdc"
  temp_volume_name       = "/dev/sdd"
  backup_volume_name     = "/dev/sde"
  data1_volume_name     = "/dev/sdf"
  data2_volume_name     = "/dev/sdg"
  data3_volume_name     = "/dev/sdh"
  data4_volume_name     = "/dev/sdi"
  data5_volume_name     = "/dev/sdj"
  
  user_data_base64       = base64encode(data.template_file.bootstrap.rendered)
  get_password_data      = true
  vpc_security_group_ids = concat([aws_security_group.default.id], [aws_security_group.sg_ms_sql_access.id], var.existing_security_groups)
  tags = merge(
    var.def_tags,
    { "Name" = var.name },
    { "ProductCode" = var.product_code },
    { "Backup_Plan" = var.backup_plan },
    { "Environment" = upper(var.env) },
    { "MaintenanceWindow" = var.maintenance_window },
    { "VPCgroup" = var.vpc_group },
    var.tags
  )
  volume_tags = merge(
    var.volume_tags,
    local.tags
  )
  sql_backups_s3_bucket = var.create_s3_backup_bucket ? aws_s3_bucket.s3_backup_bucket[0].id : var.sql_backups_s3_bucket
}

data "template_file" "bootstrap" {
  template = file("${path.module}/files/bootstrap.tpl")
  vars = {
    data_volume_name      = local.data_volume_name
    log_volume_name       = local.log_volume_name
    temp_volume_name      = local.temp_volume_name
    backup_volume_name    = local.backup_volume_name
    data1_volume_name     = local.data1_volume_name
    data2_volume_name     = local.data2_volume_name
    data3_volume_name     = local.data3_volume_name
    data4_volume_name     = local.data4_volume_name
    data5_volume_name     = local.data5_volume_name
    env                   = var.env
    sql_backups_s3_bucket = local.sql_backups_s3_bucket
  }
}

resource "random_id" "id_key" {
  byte_length = 8
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.base.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = local.vpc_security_group_ids
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id                   = var.subnet_id
  user_data_base64            = local.user_data_base64
  get_password_data           = local.get_password_data
  ebs_optimized               = true
  associate_public_ip_address = local.allowed_public_ip

  root_block_device {
    volume_size           = var.root_volume_size
    delete_on_termination = false
    encrypted             = true
    volume_type           = var.root_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.root_volume_type) == true ? var.root_volume_iops : 0
    throughput            = contains(["gp3"], var.root_volume_type) == true ? var.root_volume_throughput : 0
  }

  # SQL data volume
  ebs_block_device {
    device_name           = local.data_volume_name
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.sql_data_volume_size
    volume_type           = var.sql_data_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.sql_data_volume_type) == true ? var.sql_temp_volume_iops : 0
    throughput            = contains(["gp3"], var.sql_data_volume_type) == true ? var.sql_temp_volume_throughput : 0
  }

  # SQL logs volume
  ebs_block_device {
    device_name           = local.log_volume_name
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.sql_logs_volume_size
    volume_type           = var.sql_logs_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.sql_logs_volume_type) == true ? var.sql_logs_volume_iops : 0
    throughput            = contains(["gp3"], var.sql_logs_volume_type) == true ? var.sql_logs_volume_throughput : 0
  }

  # SQL tempdb volume
  ebs_block_device {
    device_name           = local.temp_volume_name
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.sql_temp_volume_size
    volume_type           = var.sql_temp_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.sql_temp_volume_type) == true ? var.sql_temp_volume_iops : 0
    throughput            = contains(["gp3"], var.sql_temp_volume_type) == true ? var.sql_temp_volume_throughput : 0
  }

  # SQL backup volume
  ebs_block_device {
    device_name           = local.backup_volume_name
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.sql_backup_volume_size
    volume_type           = var.sql_backup_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.sql_backup_volume_type) == true ? var.sql_backup_volume_iops : 0
    throughput            = contains(["gp3"], var.sql_backup_volume_type) == true ? var.sql_backup_volume_throughput : 0
  }
  
  # SQL DATA-1 volume
  ebs_block_device {
    device_name           = local.data1_volume_name
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.sql_data1_volume_size
    volume_type           = var.sql_data1_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.sql_data1_volume_type) == true ? var.sql_temp_volume_iops : 0
    throughput            = contains(["gp3"], var.sql_data1_volume_type) == true ? var.sql_temp_volume_throughput : 0
  }

  # SQL DATA-2 volume
  ebs_block_device {
    device_name           = local.data2_volume_name
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.sql_data2_volume_size
    volume_type           = var.sql_data2_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.sql_data2_volume_type) == true ? var.sql_temp_volume_iops : 0
    throughput            = contains(["gp3"], var.sql_data2_volume_type) == true ? var.sql_temp_volume_throughput : 0
  }

  # SQL DATA-3 volume
  ebs_block_device {
    device_name           = local.data3_volume_name
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.sql_data3_volume_size
    volume_type           = var.sql_data3_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.sql_data3_volume_type) == true ? var.sql_temp_volume_iops : 0
    throughput            = contains(["gp3"], var.sql_data3_volume_type) == true ? var.sql_temp_volume_throughput : 0
  }

  # SQL DATA-4 volume
  ebs_block_device {
    device_name           = local.data4_volume_name
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.sql_data4_volume_size
    volume_type           = var.sql_data4_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.sql_data4_volume_type) == true ? var.sql_temp_volume_iops : 0
    throughput            = contains(["gp3"], var.sql_data4_volume_type) == true ? var.sql_temp_volume_throughput : 0
  }

  # SQL DATA-5 volume
  ebs_block_device {
    device_name           = local.data5_volume_name
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.sql_data5_volume_size
    volume_type           = var.sql_data5_volume_type
    iops                  = contains(["gp3", "io1", "io2"], var.sql_data5_volume_type) == true ? var.sql_temp_volume_iops : 0
    throughput            = contains(["gp3"], var.sql_data5_volume_type) == true ? var.sql_temp_volume_throughput : 0
  }

  tags        = local.tags
  volume_tags = local.volume_tags
  lifecycle {
    #    prevent_destroy = true
    ignore_changes = [ami]
  }
}

resource "aws_ssm_parameter" "ec2_password_data" {
  name        = var.name
  description = "Encrypted password of EC2 Windows instance"
  type        = "SecureString"
  value       = aws_instance.this.password_data
  overwrite   = true
  tags        = var.tags
}

# Additional Volumes
resource "aws_ebs_volume" "instances_ebs_volume" {
  for_each          = var.ebs_volume_device
  encrypted         = true
  size              = lookup(each.value, "volume_size", null)
  type              = lookup(each.value, "volume_type", "gp3")
  iops              = lookup(each.value, "iops", null)
  availability_zone = data.aws_subnet.instance_subnet.availability_zone
  tags              = var.tags
}

resource "aws_volume_attachment" "instance_volume_attachment" {
  for_each    = var.ebs_volume_device
  device_name = lookup(each.value, "device_name", null)
  instance_id = aws_instance.this.id
  volume_id   = aws_ebs_volume.instances_ebs_volume[each.key].id
}
