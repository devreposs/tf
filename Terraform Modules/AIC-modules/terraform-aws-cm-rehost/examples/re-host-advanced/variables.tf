variable "baseline_workspace_name" {
  description = "baseline workspace name"
  type        = map(string)
  default = {
    dev = "pmi-app-landsmd-dev-baseline",
    qa  = "pmi-app-landsmd-qa-baseline",
    prd = "pmi-app-landsmd-prd-baseline"
  }
}

variable "env" {
  description = "Environment for the EC2 Instance"
  type        = string
  default     = "dev"
}

variable "product_code" {
  description = "Unique identifier across the whole DEEP platform"
  type        = string
  default     = "landsmd"
}

variable "app_server_name" {
  description = "Name to be used on all resources as prefix in application layer"
  type        = map(string)
  default = {
    dev = "test-app-dev",
    qa  = "test-app-qa",
    prd = "test-app"
  }
}

variable "app_asg_name" {
  description = "Name to be used on all resources as prefix in application layer"
  type        = map(string)
  default = {
    dev = "test-asg-app-dev",
    qa  = "test-asg-app-qa",
    prd = "test-asg-app"
  }
}

variable "web_asg_name" {
  description = "Name to be used on all resources as prefix in application layer"
  type        = map(string)
  default = {
    dev = "test-asg-web-dev",
    qa  = "test-asg-web-qa",
    prd = "test-asg-web"
  }
}

variable "db_asg_name" {
  description = "Name to be used on all resources as prefix in application layer"
  type        = map(string)
  default = {
    dev = "test-asg-db-dev",
    qa  = "test-asg-db-qa",
    prd = "test-asg-db"
  }
}
variable "db_server_name" {
  description = "Name to be used on all resources as prefix in db layer"
  type        = map(string)
  default = {
    dev = "test-db-dev",
    qa  = "test-db-qa",
    prd = "test-db"
  }
}

variable "web_server_name" {
  description = "Name to be used on all resources as prefix in web layer"
  type        = map(string)
  default = {
    dev = "test-web-dev",
    qa  = "test-web-qa",
    prd = "test-web",
  }
}

variable "web_ingress_cidr" {
  description = "cidr range to access port 80/443"
  type        = map(list(string))
  default = {
    dev = ["10.0.0.0/27"],
    qa  = ["10.0.0.0/27"],
    prd = ["10.0.0.0/27"]
  }
}

variable "application_port" {
  description = "application port"
  type        = map(string)
  default = {
    dev = "65500",
    qa  = "65500",
    prd = "65500"
  }
}

variable "asg_app_server_count" {
  description = "asg app server count"
  type        = map(number)
  default = {
    dev = 2,
    qa  = 1,
    prd = 2,
  }
}

variable "asg_web_server_count" {
  description = "asg web server count"
  type        = map(number)
  default = {
    dev = 0,
    qa  = 1,
    prd = 2,
  }
}

variable "app_server_ec2_instance_count" {
  description = "app server ec2 instance count"
  type        = map(number)
  default = {
    dev = 2,
    qa  = 1,
    prd = 2,
  }
}

variable "db_server_ec2_instance_count" {
  description = "db server ec2 instance count"
  type        = map(number)
  default = {
    dev = 1,
    qa  = 1,
    prd = 2,
  }
}

variable "web_server_ec2_instance_count" {
  description = "web server ec2 instance count"
  type        = map(number)
  default = {
    dev = 0,
    qa  = 1,
    prd = 2,
  }
}

variable "web_server_instance_type" {
  description = "web server instance type"
  type        = map(string)
  default = {
    dev = "t3.micro",
    qa  = "t3.medium",
    prd = "m5.large",
  }
}

variable "app_server_instance_type" {
  description = "app server instance type"
  type        = map(string)
  default = {
    dev = "t3.micro",
    qa  = "t3.medium",
    prd = "m5.large",
  }
}

variable "db_server_instance_type" {
  description = "db server instance type"
  type        = map(string)
  default = {
    dev = "t3.micro",
    qa  = "t3.medium",
    prd = "m5.large",
  }
}

variable "web_server_ec2_ebs_volume_device" {
  description = "web server ec2 ebs volume devices"
  type        = map(map(map(string)))
  default = {
    dev = {
      device1 = {
        device_name = "/dev/sdi",
        volume_size = 5,
      volume_type = "gp2" },
      device2 = {
        device_name = "/dev/sdj",
        volume_size = 5,
        volume_type = "io2",
      iops = 200 }
    },
    qa = {
      device1 = {
        device_name = "/dev/sdi",
        volume_size = 5,
      volume_type = "gp2" },
      device2 = {
        device_name = "/dev/sdj",
        volume_size = 5,
        volume_type = "io2",
      iops = 200 }
    },
    prd = {
      device1 = {
        device_name = "/dev/sdi",
        volume_size = 5,
      volume_type = "gp2" },
      device2 = {
        device_name = "/dev/sdj",
        volume_size = 5,
        volume_type = "io2",
      iops = 200 }
    }
  }
}

variable "app_server_ec2_ebs_volume_device" {
  description = "app server ec2 ebs volume device"
  type        = map(map(map(string)))
  default = {
    dev = {
      device1 = {
        device_name = "/dev/sdi",
        volume_size = 5,
      volume_type = "gp2" },
      device2 = {
        device_name = "/dev/sdj",
        volume_size = 5,
        volume_type = "io2",
      iops = 200 }
    },
    qa = {
      device1 = {
        device_name = "/dev/sdi",
        volume_size = 5,
      volume_type = "gp2" },
      device2 = {
        device_name = "/dev/sdj",
        volume_size = 5,
        volume_type = "io2",
      iops = 200 }
    },
    prd = {
      device1 = {
        device_name = "/dev/sdi",
        volume_size = 5,
      volume_type = "gp2" },
      device2 = {
        device_name = "/dev/sdj",
        volume_size = 5,
        volume_type = "io2",
      iops = 200 }
    }
  }
}

variable "db_server_ec2_ebs_volume_device" {
  description = "db server ec2 ebs volume device"
  type        = map(map(map(string)))
  default = {
    dev = {
      device1 = {
        device_name = "/dev/sdi",
        volume_size = 5,
      volume_type = "gp2" },
      device2 = {
        device_name = "/dev/sdj",
        volume_size = 5,
        volume_type = "io2",
      iops = 200 }
    },
    qa = {
      device1 = {
        device_name = "/dev/sdi",
        volume_size = 5,
      volume_type = "gp2" },
      device2 = {
        device_name = "/dev/sdj",
        volume_size = 5,
        volume_type = "io2",
      iops = 200 }
    },
    prd = {
      device1 = {
        device_name = "/dev/sdi",
        volume_size = 5,
      volume_type = "gp2" },
      device2 = {
        device_name = "/dev/sdj",
        volume_size = 5,
        volume_type = "io2",
      iops = 200 }
    }
  }
}

variable "app_server_platform" {
  description = "app server platform"
  type        = string
  default     = "windows"
}

variable "db_server_platform" {
  description = "db server platform"
  type        = string
  default     = "windows"
}

variable "web_server_platform" {
  description = "web server platform"
  type        = string
  default     = "linux"
}

variable "app_server_os" {
  description = "app server os"
  type        = string
  default     = "windows2019"
}

variable "db_server_os" {
  description = "db server os"
  type        = string
  default     = "windows2016"
}

variable "web_server_os" {
  description = "web server os"
  type        = string
  default     = "amazonlinux2"
}


variable "asg_app_server_asg_name" {
  description = "asg app server asg name"
  type        = string
  default     = "app-asg"
}

variable "asg_web_server_asg_name" {
  description = "asg web server asg name"
  type        = string
  default     = "web-asg"
}

variable "asg_app_server_create_lc" {
  description = "asg app server create launch configuration"
  type        = string
  default     = "true"
}

variable "asg_web_server_create_lc" {
  description = "asg web server create launch configuration"
  type        = string
  default     = "true"
}

variable "asg_app_server_lc_name" {
  description = "asg app server launch configuration name"
  type        = string
  default     = "app-lc"
}

variable "asg_web_server_lc_name" {
  description = "asg web server launch configuration name"
  type        = string
  default     = "web-lc"
}

variable "asg_app_server_recreate_asg_when_lc_changes" {
  description = "asg app server recreate asg when lc changes"
  type        = map(bool)
  default = {
    dev = false,
    qa  = true,
    prd = true
  }
}

variable "asg_web_server_recreate_asg_when_lc_changes" {
  description = "asg web server recreate asg when lc changes"
  type        = map(bool)
  default = {
    dev = true,
    qa  = true,
    prd = true
  }
}

variable "asg_app_server_instance_type" {
  description = "asg app server instance type"
  type        = map(string)
  default = {
    dev = "t2.micro",
    qa  = "t3.micro",
    prd = "m5.large"
  }
}

variable "asg_app_server_associate_public_ip_address" {
  description = "Flag for asg app server associate public ip address"
  type        = string
  default     = "false"
}

variable "asg_app_server_enable_monitoring" {
  description = "asg app server enable monitoring"
  type        = map(string)
  default = {
    dev = "true",
    qa  = "false",
    prd = "true"
  }
}

variable "asg_app_server_ebs_optimized" {
  description = "asg app server ebs optimized"
  type        = map(string)
  default = {
    dev = "false",
    qa  = "false",
    prd = "true"
  }
}

variable "asg_app_server_spot_price" {
  description = "asg app server spot price"
  type        = map(string)
  default = {
    dev = "10",
    qa  = "10",
    prd = "10"
  }
}

variable "asg_app_server_max_size" {
  description = "asg app server max size"
  type        = map(number)
  default = {
    dev = 3,
    qa  = 3,
    prd = 5
  }
}

variable "asg_app_server_min_size" {
  description = "asg app server min size"
  type        = map(number)
  default = {
    dev = 1,
    qa  = 1,
    prd = 2
  }
}

variable "asg_app_server_desired_capacity" {
  description = "asg app server desired size"
  type        = map(number)
  default = {
    dev = 2,
    qa  = 2,
    prd = 3
  }
}

variable "asg_app_server_force_delete" {
  description = "asg app server force delete"
  type        = string
  default     = "true"
}

variable "asg_app_server_suspended_processes" {
  description = "asg app server suspended processes"
  type        = map(list(string))
  default = {
    dev = ["HealthCheck", "AZRebalance"],
    qa  = ["HealthCheck", "AZRebalance"],
    prd = ["HealthCheck", "AZRebalance"]
  }
}
