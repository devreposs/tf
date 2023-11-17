locals {
  ami_filter_list = {
    enterprise2016 = "deep-std-sql-enterprise-windowsserver2016-*"
    standard2016   = "deep-std-sql-standard-windowsserver2016-*"
    enterprise2019 = "deep-std-sql-enterprise-windowsserver2019-*"
    standard2019   = "deep-std-sql-standard-windowsserver2019-*"
  }
  selected_filter = [local.ami_filter_list[local.selected_sql_filter]]
}

data "aws_ami" "base" {
  most_recent = true
  owners      = ["630707141366"]
  filter {
    name   = "name"
    values = local.selected_filter
  }
}
