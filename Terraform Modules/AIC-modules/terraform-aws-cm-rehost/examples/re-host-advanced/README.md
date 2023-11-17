## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |
| terraform | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_asg\_name | Name to be used on all resources as prefix in application layer | `map(string)` | <pre>{<br>  "dev": "test-asg-app-dev",<br>  "prd": "test-asg-app",<br>  "qa": "test-asg-app-qa"<br>}</pre> | no |
| app\_server\_ec2\_ebs\_volume\_device | app server ec2 ebs volume device | `map(map(map(string)))` | <pre>{<br>  "dev": {<br>    "device1": {<br>      "device_name": "/dev/sdi",<br>      "volume_size": 5,<br>      "volume_type": "gp2"<br>    },<br>    "device2": {<br>      "device_name": "/dev/sdj",<br>      "iops": 200,<br>      "volume_size": 5,<br>      "volume_type": "io2"<br>    }<br>  },<br>  "prd": {<br>    "device1": {<br>      "device_name": "/dev/sdi",<br>      "volume_size": 5,<br>      "volume_type": "gp2"<br>    },<br>    "device2": {<br>      "device_name": "/dev/sdj",<br>      "iops": 200,<br>      "volume_size": 5,<br>      "volume_type": "io2"<br>    }<br>  },<br>  "qa": {<br>    "device1": {<br>      "device_name": "/dev/sdi",<br>      "volume_size": 5,<br>      "volume_type": "gp2"<br>    },<br>    "device2": {<br>      "device_name": "/dev/sdj",<br>      "iops": 200,<br>      "volume_size": 5,<br>      "volume_type": "io2"<br>    }<br>  }<br>}</pre> | no |
| app\_server\_ec2\_instance\_count | app server ec2 instance count | `map(number)` | <pre>{<br>  "dev": 2,<br>  "prd": 2,<br>  "qa": 1<br>}</pre> | no |
| app\_server\_instance\_type | app server instance type | `map(string)` | <pre>{<br>  "dev": "t3.micro",<br>  "prd": "m5.large",<br>  "qa": "t3.medium"<br>}</pre> | no |
| app\_server\_name | Name to be used on all resources as prefix in application layer | `map(string)` | <pre>{<br>  "dev": "test-app-dev",<br>  "prd": "test-app",<br>  "qa": "test-app-qa"<br>}</pre> | no |
| app\_server\_os | app server os | `string` | `"windows2019"` | no |
| app\_server\_platform | app server platform | `string` | `"windows"` | no |
| application\_port | application port | `map(string)` | <pre>{<br>  "dev": "65500",<br>  "prd": "65500",<br>  "qa": "65500"<br>}</pre> | no |
| asg\_app\_server\_asg\_name | asg app server asg name | `string` | `"app-asg"` | no |
| asg\_app\_server\_associate\_public\_ip\_address | Flag for asg app server associate public ip address | `string` | `"false"` | no |
| asg\_app\_server\_count | asg app server count | `map(number)` | <pre>{<br>  "dev": 2,<br>  "prd": 2,<br>  "qa": 1<br>}</pre> | no |
| asg\_app\_server\_create\_lc | asg app server create launch configuration | `string` | `"true"` | no |
| asg\_app\_server\_desired\_capacity | asg app server desired size | `map(number)` | <pre>{<br>  "dev": 2,<br>  "prd": 3,<br>  "qa": 2<br>}</pre> | no |
| asg\_app\_server\_ebs\_optimized | asg app server ebs optimized | `map(string)` | <pre>{<br>  "dev": "false",<br>  "prd": "true",<br>  "qa": "false"<br>}</pre> | no |
| asg\_app\_server\_enable\_monitoring | asg app server enable monitoring | `map(string)` | <pre>{<br>  "dev": "true",<br>  "prd": "true",<br>  "qa": "false"<br>}</pre> | no |
| asg\_app\_server\_force\_delete | asg app server force delete | `string` | `"true"` | no |
| asg\_app\_server\_instance\_type | asg app server instance type | `map(string)` | <pre>{<br>  "dev": "t2.micro",<br>  "prd": "m5.large",<br>  "qa": "t3.micro"<br>}</pre> | no |
| asg\_app\_server\_lc\_name | asg app server launch configuration name | `string` | `"app-lc"` | no |
| asg\_app\_server\_max\_size | asg app server max size | `map(number)` | <pre>{<br>  "dev": 3,<br>  "prd": 5,<br>  "qa": 3<br>}</pre> | no |
| asg\_app\_server\_min\_size | asg app server min size | `map(number)` | <pre>{<br>  "dev": 1,<br>  "prd": 2,<br>  "qa": 1<br>}</pre> | no |
| asg\_app\_server\_recreate\_asg\_when\_lc\_changes | asg app server recreate asg when lc changes | `map(bool)` | <pre>{<br>  "dev": false,<br>  "prd": true,<br>  "qa": true<br>}</pre> | no |
| asg\_app\_server\_spot\_price | asg app server spot price | `map(string)` | <pre>{<br>  "dev": "10",<br>  "prd": "10",<br>  "qa": "10"<br>}</pre> | no |
| asg\_app\_server\_suspended\_processes | asg app server suspended processes | `map(list(string))` | <pre>{<br>  "dev": [<br>    "HealthCheck",<br>    "AZRebalance"<br>  ],<br>  "prd": [<br>    "HealthCheck",<br>    "AZRebalance"<br>  ],<br>  "qa": [<br>    "HealthCheck",<br>    "AZRebalance"<br>  ]<br>}</pre> | no |
| asg\_web\_server\_asg\_name | asg web server asg name | `string` | `"web-asg"` | no |
| asg\_web\_server\_count | asg web server count | `map(number)` | <pre>{<br>  "dev": 0,<br>  "prd": 2,<br>  "qa": 1<br>}</pre> | no |
| asg\_web\_server\_create\_lc | asg web server create launch configuration | `string` | `"true"` | no |
| asg\_web\_server\_lc\_name | asg web server launch configuration name | `string` | `"web-lc"` | no |
| asg\_web\_server\_recreate\_asg\_when\_lc\_changes | asg web server recreate asg when lc changes | `map(bool)` | <pre>{<br>  "dev": true,<br>  "prd": true,<br>  "qa": true<br>}</pre> | no |
| baseline\_workspace\_name | baseline workspace name | `map(string)` | <pre>{<br>  "dev": "pmi-app-landsmd-dev-baseline",<br>  "prd": "pmi-app-landsmd-prd-baseline",<br>  "qa": "pmi-app-landsmd-qa-baseline"<br>}</pre> | no |
| db\_asg\_name | Name to be used on all resources as prefix in application layer | `map(string)` | <pre>{<br>  "dev": "test-asg-db-dev",<br>  "prd": "test-asg-db",<br>  "qa": "test-asg-db-qa"<br>}</pre> | no |
| db\_server\_ec2\_ebs\_volume\_device | db server ec2 ebs volume device | `map(map(map(string)))` | <pre>{<br>  "dev": {<br>    "device1": {<br>      "device_name": "/dev/sdi",<br>      "volume_size": 5,<br>      "volume_type": "gp2"<br>    },<br>    "device2": {<br>      "device_name": "/dev/sdj",<br>      "iops": 200,<br>      "volume_size": 5,<br>      "volume_type": "io2"<br>    }<br>  },<br>  "prd": {<br>    "device1": {<br>      "device_name": "/dev/sdi",<br>      "volume_size": 5,<br>      "volume_type": "gp2"<br>    },<br>    "device2": {<br>      "device_name": "/dev/sdj",<br>      "iops": 200,<br>      "volume_size": 5,<br>      "volume_type": "io2"<br>    }<br>  },<br>  "qa": {<br>    "device1": {<br>      "device_name": "/dev/sdi",<br>      "volume_size": 5,<br>      "volume_type": "gp2"<br>    },<br>    "device2": {<br>      "device_name": "/dev/sdj",<br>      "iops": 200,<br>      "volume_size": 5,<br>      "volume_type": "io2"<br>    }<br>  }<br>}</pre> | no |
| db\_server\_ec2\_instance\_count | db server ec2 instance count | `map(number)` | <pre>{<br>  "dev": 1,<br>  "prd": 2,<br>  "qa": 1<br>}</pre> | no |
| db\_server\_instance\_type | db server instance type | `map(string)` | <pre>{<br>  "dev": "t3.micro",<br>  "prd": "m5.large",<br>  "qa": "t3.medium"<br>}</pre> | no |
| db\_server\_name | Name to be used on all resources as prefix in db layer | `map(string)` | <pre>{<br>  "dev": "test-db-dev",<br>  "prd": "test-db",<br>  "qa": "test-db-qa"<br>}</pre> | no |
| db\_server\_os | db server os | `string` | `"windows2016"` | no |
| db\_server\_platform | db server platform | `string` | `"windows"` | no |
| env | Environment for the EC2 Instance | `string` | `"dev"` | no |
| product\_code | Unique identifier across the whole DEEP platform | `string` | `"landsmd"` | no |
| web\_asg\_name | Name to be used on all resources as prefix in application layer | `map(string)` | <pre>{<br>  "dev": "test-asg-web-dev",<br>  "prd": "test-asg-web",<br>  "qa": "test-asg-web-qa"<br>}</pre> | no |
| web\_ingress\_cidr | cidr range to access port 80/443 | `map(list(string))` | <pre>{<br>  "dev": [<br>    "10.0.0.0/27"<br>  ],<br>  "prd": [<br>    "10.0.0.0/27"<br>  ],<br>  "qa": [<br>    "10.0.0.0/27"<br>  ]<br>}</pre> | no |
| web\_server\_ec2\_ebs\_volume\_device | web server ec2 ebs volume devices | `map(map(map(string)))` | <pre>{<br>  "dev": {<br>    "device1": {<br>      "device_name": "/dev/sdi",<br>      "volume_size": 5,<br>      "volume_type": "gp2"<br>    },<br>    "device2": {<br>      "device_name": "/dev/sdj",<br>      "iops": 200,<br>      "volume_size": 5,<br>      "volume_type": "io2"<br>    }<br>  },<br>  "prd": {<br>    "device1": {<br>      "device_name": "/dev/sdi",<br>      "volume_size": 5,<br>      "volume_type": "gp2"<br>    },<br>    "device2": {<br>      "device_name": "/dev/sdj",<br>      "iops": 200,<br>      "volume_size": 5,<br>      "volume_type": "io2"<br>    }<br>  },<br>  "qa": {<br>    "device1": {<br>      "device_name": "/dev/sdi",<br>      "volume_size": 5,<br>      "volume_type": "gp2"<br>    },<br>    "device2": {<br>      "device_name": "/dev/sdj",<br>      "iops": 200,<br>      "volume_size": 5,<br>      "volume_type": "io2"<br>    }<br>  }<br>}</pre> | no |
| web\_server\_ec2\_instance\_count | web server ec2 instance count | `map(number)` | <pre>{<br>  "dev": 0,<br>  "prd": 2,<br>  "qa": 1<br>}</pre> | no |
| web\_server\_instance\_type | web server instance type | `map(string)` | <pre>{<br>  "dev": "t3.micro",<br>  "prd": "m5.large",<br>  "qa": "t3.medium"<br>}</pre> | no |
| web\_server\_name | Name to be used on all resources as prefix in web layer | `map(string)` | <pre>{<br>  "dev": "test-web-dev",<br>  "prd": "test-web",<br>  "qa": "test-web-qa"<br>}</pre> | no |
| web\_server\_os | web server os | `string` | `"amazonlinux2"` | no |
| web\_server\_platform | web server platform | `string` | `"linux"` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_server\_ec2\_arn | List of ARNs of instances |
| app\_server\_ec2\_ids | List of instance ids |
| app\_server\_ec2\_private\_ip | Private IP for the instance |
| app\_server\_ec2\_public\_ip | Public IP for the instance, if applicable. |
| app\_server\_ec2\_security\_groups | List of associated security groups of instances |
| app\_server\_ec2\_tags | List of tags of instances |
| app\_server\_ec2\_volume\_tags | List of tags of volumes of instances |
| asg\_app\_server\_autoscaling\_group\_arn | The ARN for this AutoScaling Group |
| asg\_app\_server\_autoscaling\_group\_availability\_zones | The availability zones of the autoscale group |
| asg\_app\_server\_autoscaling\_group\_default\_cooldown | Time between a scaling activity and the succeeding scaling activity |
| asg\_app\_server\_autoscaling\_group\_desired\_capacity | The number of Amazon EC2 instances that should be running in the group |
| asg\_app\_server\_autoscaling\_group\_health\_check\_grace\_period | Time after instance comes into service before checking health |
| asg\_app\_server\_autoscaling\_group\_health\_check\_type | EC2 or ELB. Controls how health checking is done |
| asg\_app\_server\_autoscaling\_group\_id | The autoscaling group id |
| asg\_app\_server\_autoscaling\_group\_load\_balancers | The load balancer names associated with the autoscaling group |
| asg\_app\_server\_autoscaling\_group\_max\_size | The maximum size of the autoscale group |
| asg\_app\_server\_autoscaling\_group\_min\_size | The minimum size of the autoscale group |
| asg\_app\_server\_autoscaling\_group\_name | The autoscaling group name |
| asg\_app\_server\_autoscaling\_group\_target\_group\_arns | List of Target Group ARNs that apply to this AutoScaling Group |
| asg\_app\_server\_autoscaling\_group\_vpc\_zone\_identifier | The VPC zone identifier |
| asg\_app\_server\_launch\_configuration\_id | The ID of the launch configuration |
| asg\_app\_server\_launch\_configuration\_name | The name of the launch configuration |
| asg\_web\_server\_autoscaling\_group\_arn | The ARN for this AutoScaling Group |
| asg\_web\_server\_autoscaling\_group\_availability\_zones | The availability zones of the autoscale group |
| asg\_web\_server\_autoscaling\_group\_default\_cooldown | Time between a scaling activity and the succeeding scaling activity |
| asg\_web\_server\_autoscaling\_group\_desired\_capacity | The number of Amazon EC2 instances that should be running in the group |
| asg\_web\_server\_autoscaling\_group\_health\_check\_grace\_period | Time after instance comes into service before checking health |
| asg\_web\_server\_autoscaling\_group\_health\_check\_type | EC2 or ELB. Controls how health checking is done |
| asg\_web\_server\_autoscaling\_group\_id | The autoscaling group id |
| asg\_web\_server\_autoscaling\_group\_load\_balancers | The load balancer names associated with the autoscaling group |
| asg\_web\_server\_autoscaling\_group\_max\_size | The maximum size of the autoscale group |
| asg\_web\_server\_autoscaling\_group\_min\_size | The minimum size of the autoscale group |
| asg\_web\_server\_autoscaling\_group\_name | The autoscaling group name |
| asg\_web\_server\_autoscaling\_group\_target\_group\_arns | List of Target Group ARNs that apply to this AutoScaling Group |
| asg\_web\_server\_autoscaling\_group\_vpc\_zone\_identifier | The VPC zone identifier |
| asg\_web\_server\_launch\_configuration\_id | The ID of the launch configuration |
| asg\_web\_server\_launch\_configuration\_name | The name of the launch configuration |
| db\_server\_client\_security\_groups | Security group allowing clients access to the MS SQL Server |
| db\_server\_ec2\_arn | List of ARNs of instances |
| db\_server\_ec2\_ids | List of instance ids |
| db\_server\_ec2\_private\_ip | Private IP for the instance |
| db\_server\_ec2\_public\_ip | Public IP for the instance, if databaselicable. |
| db\_server\_ec2\_security\_groups | List of associated security groups of instances |
| db\_server\_ec2\_tags | List of tags of instances |
| db\_server\_ec2\_volume\_tags | List of tags of volumes of instances |
| db\_server\_instance\_bucket | S3 Bucket created for dumping backups to S3 |
| db\_server\_instance\_bucket\_arn | ARN of S3 Bucket created for dumping backups to S3 |
| db\_server\_instance\_bucket\_domain | Domain of S3 Bucket created for dumping backups to S3 |
| web\_server\_ec2\_arn | List of ARNs of instances |
| web\_server\_ec2\_ids | List of instance ids |
| web\_server\_ec2\_private\_ip | Private IP for the instance |
| web\_server\_ec2\_public\_ip | Public IP for the instance, if applicable. |
| web\_server\_ec2\_security\_groups | List of associated security groups of instances |
| web\_server\_ec2\_tags | List of tags of instances |
| web\_server\_ec2\_volume\_tags | List of tags of volumes of instances |
