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
| app\_server\_ec2\_instance\_count | app server ec2 instance count | `map(number)` | <pre>{<br>  "dev": 1,<br>  "prd": 1,<br>  "qa": 1<br>}</pre> | no |
| app\_server\_name | Name to be used on all resources as prefix in application layer | `map(string)` | <pre>{<br>  "dev": "test-app-dev",<br>  "prd": "test-app",<br>  "qa": "test-app-qa"<br>}</pre> | no |
| asg\_app\_server\_count | asg app server count | `map(number)` | <pre>{<br>  "dev": 1,<br>  "prd": 1,<br>  "qa": 1<br>}</pre> | no |
| asg\_web\_server\_count | asg web server count | `map(number)` | <pre>{<br>  "dev": 1,<br>  "prd": 1,<br>  "qa": 1<br>}</pre> | no |
| baseline\_workspace\_name | baseline workspace name | `map(string)` | <pre>{<br>  "dev": "pmi-app-landsmd-dev-baseline",<br>  "prd": "pmi-app-landsmd-prd-baseline",<br>  "qa": "pmi-app-landsmd-qa-baseline"<br>}</pre> | no |
| db\_server\_ec2\_instance\_count | db server ec2 instance count | `map(number)` | <pre>{<br>  "dev": 1,<br>  "prd": 1,<br>  "qa": 1<br>}</pre> | no |
| db\_server\_name | Name to be used on all resources as prefix in db layer | `map(string)` | <pre>{<br>  "dev": "test-db-dev",<br>  "prd": "test-db",<br>  "qa": "test-db-qa"<br>}</pre> | no |
| env | Environment for the EC2 Instance | `string` | `"dev"` | no |
| product\_code | Unique identifier across the whole DEEP platform | `string` | `"landsmd"` | no |
| web\_server\_ec2\_instance\_count | web server ec2 instance count | `map(number)` | <pre>{<br>  "dev": 1,<br>  "prd": 1,<br>  "qa": 1<br>}</pre> | no |
| web\_server\_name | Name to be used on all resources as prefix in web layer | `map(string)` | <pre>{<br>  "dev": "test-web-dev",<br>  "prd": "test-web",<br>  "qa": "test-web-qa"<br>}</pre> | no |

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
