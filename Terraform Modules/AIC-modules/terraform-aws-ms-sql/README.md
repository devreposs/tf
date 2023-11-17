## Providers

| Name | Version |
|------|---------|
| aws | >= 3.5.0, < 4.0 |
| random | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| allowed\_ips | List of IP addresses that have SSH or RDP access to the instance | `list(string)` | `[]` | no |
| backup\_plan | A tag for back up plan that needs to be specified | `string` | `"default"` | no |
| create\_s3\_backup\_bucket | Create S3 bucket for backups | `bool` | `true` | no |
| db\_port | Port that database should listen to. Used for SecurityGroups and instance config | `string` | `"1433"` | no |
| def\_tags | A map of default tags to add to all resources | `map` | <pre>{<br>  "Terraform": "true"<br>}</pre> | no |
| ebs\_volume\_device | EBS volumes to be created that needs to be attached to the instance | `map(map(string))` | `{}` | no |
| ec2\_security\_group\_prefix | Prefix of security group name to create | `string` | `"ec2_module_instance_security_group"` | no |
| env | Environment for the EC2 Instance | `string` | n/a | yes |
| existing\_security\_groups | Specify a list of security group ids that the instance should have | `list(string)` | `[]` | no |
| iam\_policy\_arn | List of policies to be assigned to the EC2 Instance | `map(string)` | `{}` | no |
| instance\_type | The type of instance to start | `string` | n/a | yes |
| key\_name | The key name to use for the instance | `any` | n/a | yes |
| maintenance\_window | Specifying maintenance window for the EC2 Instance | `string` | `"TUE_01"` | no |
| name | Name to be used on all resources as prefix | `string` | n/a | yes |
| product\_code | Unique identifier across the whole DEEP platform | `any` | n/a | yes |
| root\_volume\_iops | Volume iops for the root block device of the instance | `string` | `"0"` | no |
| root\_volume\_size | Volume size for the root block device of the instance | `string` | `"70"` | no |
| root\_volume\_throughput | Volume throughput for the root block device of the instance | `string` | `"0"` | no |
| root\_volume\_type | Volume type for the root block device of the instance | `string` | `"gp3"` | no |
| sql\_backup\_volume\_iops | Volume iops for the SQL Backups | `string` | `"0"` | no |
| sql\_backup\_volume\_size | Volume size for the SQL Backups | `string` | `"10"` | no |
| sql\_backup\_volume\_throughput | Volume throughput for the SQL Backups | `string` | `"0"` | no |
| sql\_backup\_volume\_type | Volume type for the SQL Backups | `string` | `"gp3"` | no |
| sql\_backups\_s3\_bucket | S3 bucket name for MSSQL backups | `string` | n/a | yes |
| sql\_data\_volume\_iops | Volume iops for the SQL Data | `string` | `"0"` | no |
| sql\_data\_volume\_size | Volume size for the SQL Data | `string` | `"10"` | no |
| sql\_data\_volume\_throughput | Volume iops for the SQL Data | `string` | `"0"` | no |
| sql\_data\_volume\_type | Volume type for the SQL Data | `string` | `"gp3"` | no |
| sql\_edition | SQl server version - enterprise or standard | `string` | n/a | yes |
| sql\_logs\_volume\_iops | Volume iops for the SQL Logs | `string` | `"0"` | no |
| sql\_logs\_volume\_size | Volume size for the SQL Logs | `string` | `"10"` | no |
| sql\_logs\_volume\_throughput | Volume throughput for the SQL Logs | `string` | `"0"` | no |
| sql\_logs\_volume\_type | Volume type for the SQL Logs | `string` | `"gp3"` | no |
| sql\_temp\_volume\_iops | Volume iops for the SQL Tempdb | `string` | `"0"` | no |
| sql\_temp\_volume\_size | Volume size for the SQL Tempdb | `string` | `"10"` | no |
| sql\_temp\_volume\_throughput | Volume throughput for the SQL Tempdb | `string` | `"0"` | no |
| sql\_temp\_volume\_type | Volume type for the SQL Tempdb | `string` | `"gp3"` | no |
| sql\_version | SQl server version - 2016 or 2019 | `string` | n/a | yes |
| subnet\_id | The VPC Subnet ID to launch in | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| user\_data | Contents of EC2 user-data | `string` | `""` | no |
| volume\_tags | A mapping of tags to assign to the devices created by the instance at launch time | `map(string)` | `{}` | no |
| vpc\_group | Specifying vpc mode tag for the EC2 Instance | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | EC2 instance ARN |
| client\_security\_groups | Security group allowing clients access to the MS SQL Server |
| id | EC2 instance ID |
| instance\_bucket | S3 Bucket created for dumping backups to S3 |
| instance\_bucket\_arn | ARN of S3 Bucket created for dumping backups to S3 |
| instance\_bucket\_domain | Domain of S3 Bucket created for dumping backups to S3 |
| ms\_sql | n/a |
| password\_parameter | Password Data from the instance is stored in secure string under SSM |
| private\_ip | Private IP of the instance |
| security\_groups | List of associated security groups |
| tags | List of tags set for the instance |
| volume\_tags | List of tags set for the instance volumes |

