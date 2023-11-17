## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13, < 0.14 |
| aws | >= 3.5.0, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | >= 3.5.0, < 4.0 |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_app\_server\_security\_groups | A list of additional security group IDs to assign to the launch configuration | `list(string)` | `[]` | no |
| additional\_asg\_app\_server\_security\_groups | A list of additional security group IDs to assign to the launch configuration | `list(string)` | `[]` | no |
| additional\_asg\_web\_server\_security\_groups | A list of additional security group IDs to assign to the launch configuration | `list(string)` | `[]` | no |
| additional\_db\_server\_security\_groups | Specify a list of security group ids that the instance should have | `list(string)` | `[]` | no |
| additional\_web\_server\_security\_groups | A list of additional security group IDs to assign to the launch configuration | `list(string)` | `[]` | no |
| ansible\_bucket\_policy\_name | Name of iam policy used to access ansible bucket. | `string` | `"ansible-configuration-s3-bucket-policy"` | no |
| ansible\_config\_bucket\_name | Ansible configuration bucket name. | `string` | `""` | no |
| ansible\_secrets\_parameter\_name | Parameter store name for ansible secret | `string` | `"/ansible/secrets"` | no |
| ansible\_secrets\_parameter\_policy\_name | IAM Policy name for access to Parameter store for ansible secret | `string` | `"ansible-secrets-parameter-store-policy"` | no |
| ansible\_server\_url | Ansible Server Url | `string` | `""` | no |
| ansible\_token | Secrets for ansible configuration | `string` | `""` | no |
| app\_server\_allowed\_ips\_for\_ssh\_rdp | List of IP addresses that have SSH or RDP access to the instance | `list(string)` | `[]` | no |
| app\_server\_allowed\_ips\_for\_winrm | List of IP addresses that have winrm access to the instance | `list(string)` | `[]` | no |
| app\_server\_auto\_recovery\_alarm | Create auto recovery alarm for service instances | `bool` | `false` | no |
| app\_server\_ec2\_backup\_plan | A tag for back up plan that needs to be specified in app server layer | `string` | `"default"` | no |
| app\_server\_ec2\_ebs\_volume\_device | EBS volumes to be created that needs to be attached to the instance | `map(map(string))` | <pre>{<br>  "device1": {<br>    "device_name": "/dev/sdf",<br>    "volume_size": "20"<br>  }<br>}</pre> | no |
| app\_server\_ec2\_iam\_policy\_arn | List of policies to be assigned to the EC2 Instance in app server layer | `map(string)` | `{}` | no |
| app\_server\_ec2\_instance\_count | Number of instances to launch in app server layer | `number` | `0` | no |
| app\_server\_ec2\_maintenance\_window | The type of instance to start in app server layer | `string` | `"SUN_00"` | no |
| app\_server\_ec2\_root\_volume\_size | Volume size for the root block device of the instance in app server layer | `string` | `""` | no |
| app\_server\_ec2\_tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| app\_server\_ec2\_volume\_tags | A mapping of tags to assign to the devices created by the instance at launch time | `map(string)` | `{}` | no |
| app\_server\_instance\_type | The type of instance to start in service layer | `string` | `"t2.micro"` | no |
| app\_server\_join\_domain | whether appserver will join PMINTL.NET domain | `bool` | `false` | no |
| app\_server\_name | Name to be used on all resources as prefix in app layer | `string` | `""` | no |
| app\_server\_os | Name of AMI to use for the instance, give windows or linux as a value in service layer | `string` | `"windows2019"` | no |
| app\_server\_platform | Name of AMI to use for the instance, give windows or linux as a value in service layer | `string` | `"windows"` | no |
| app\_server\_subnet\_ids | Number of instances to launch in service layer | `list(string)` | `[]` | no |
| app\_server\_user\_data | Contents of EC2 user-data | `string` | `""` | no |
| asg\_app\_server\_ansible\_extra\_var | Ansible appserver extravar | `string` | `""` | no |
| asg\_app\_server\_ansible\_extra\_var\_parameter\_name | Ansible appserver asg extra var parameter name | `string` | `"/ansible/appserver/extravar"` | no |
| asg\_app\_server\_ansible\_extra\_var\_parameter\_policy\_name | Ansible appserver asg extra var parameter name | `string` | `"asg-appserver-ansible-extravar-parameter-store-policy"` | no |
| asg\_app\_server\_ansible\_jobtemplateid | Ansible appserver asg jobtemplate name pmi-app-<project_code>-<environment>-ansible-job-template | `string` | `""` | no |
| asg\_app\_server\_asg\_name | Creates a unique name for autoscaling group beginning with the specified prefix | `string` | `""` | no |
| asg\_app\_server\_associate\_public\_ip\_address | Associate a public ip address with an instance in a VPC | `bool` | `false` | no |
| asg\_app\_server\_association\_name | SSM Association name for asg appserver | `string` | `"asg-app-server-association-ansible-config"` | no |
| asg\_app\_server\_association\_target\_tag | Target tag key value for ssm association for asg appserver | `map(string)` | `{}` | no |
| asg\_app\_server\_backup\_plan | A tag for back up plan that needs to be specified in app server layer | `string` | `"default"` | no |
| asg\_app\_server\_count | Number of autoscaling group in app layer | `number` | `0` | no |
| asg\_app\_server\_create\_asg | Whether to create autoscaling group | `bool` | `true` | no |
| asg\_app\_server\_create\_asg\_with\_initial\_lifecycle\_hook | Create an ASG with initial lifecycle hook | `bool` | `false` | no |
| asg\_app\_server\_create\_lc | Whether to create launch configuration | `bool` | `true` | no |
| asg\_app\_server\_default\_cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `300` | no |
| asg\_app\_server\_desired\_capacity | The number of Amazon EC2 instances that should be running in the group | `string` | `"0"` | no |
| asg\_app\_server\_ebs\_block\_device | Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| asg\_app\_server\_ebs\_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| asg\_app\_server\_enable\_monitoring | Enables/disables detailed monitoring. This is enabled by default. | `bool` | `true` | no |
| asg\_app\_server\_ephemeral\_block\_device | Customize Ephemeral (also known as 'Instance Store') volumes on the instance | `list(map(string))` | `[]` | no |
| asg\_app\_server\_force\_delete | Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling | `bool` | `false` | no |
| asg\_app\_server\_health\_check\_grace\_period | Time (in seconds) after instance comes into service before checking health | `number` | `300` | no |
| asg\_app\_server\_health\_check\_type | Controls how health checking is done. Values are - EC2 and ELB | `string` | `"EC2"` | no |
| asg\_app\_server\_iam\_policy\_arn | List of policies to be assigned to the asg app server | `map(string)` | `{}` | no |
| asg\_app\_server\_image\_id | The EC2 image ID to launch | `string` | `""` | no |
| asg\_app\_server\_initial\_lifecycle\_hook\_default\_result | Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON | `string` | `"ABANDON"` | no |
| asg\_app\_server\_initial\_lifecycle\_hook\_heartbeat\_timeout | Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter | `string` | `"60"` | no |
| asg\_app\_server\_initial\_lifecycle\_hook\_lifecycle\_transition | The instance state to which you want to attach the initial lifecycle hook | `string` | `""` | no |
| asg\_app\_server\_initial\_lifecycle\_hook\_name | The name of initial lifecycle hook | `string` | `""` | no |
| asg\_app\_server\_initial\_lifecycle\_hook\_notification\_metadata | Contains additional information that you want to include any time Auto Scaling sends a message to the notification target | `string` | `""` | no |
| asg\_app\_server\_initial\_lifecycle\_hook\_notification\_target\_arn | The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic | `string` | `""` | no |
| asg\_app\_server\_initial\_lifecycle\_hook\_role\_arn | The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target | `string` | `""` | no |
| asg\_app\_server\_instance\_type | The size of instance to launch | `string` | `"t2.micro"` | no |
| asg\_app\_server\_join\_domain | whether asg appserver will join PMINTL.NET domain | `bool` | `false` | no |
| asg\_app\_server\_key\_name | The key name that should be used for the instance | `string` | `""` | no |
| asg\_app\_server\_launch\_configuration | The name of the launch configuration to use (if it is created outside of this module) | `string` | `""` | no |
| asg\_app\_server\_lc\_name | Creates a unique name for launch configuration beginning with the specified prefix | `string` | `""` | no |
| asg\_app\_server\_load\_balancers | A list of elastic load balancer names to add to the autoscaling group names | `list(string)` | `[]` | no |
| asg\_app\_server\_max\_instance\_lifetime | The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds. | `number` | `0` | no |
| asg\_app\_server\_max\_size | The maximum size of the auto scale group | `string` | `"0"` | no |
| asg\_app\_server\_metrics\_granularity | The granularity to associate with the metrics to collect. The only valid value is 1Minute | `string` | `"1Minute"` | no |
| asg\_app\_server\_min\_elb\_capacity | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | `number` | `0` | no |
| asg\_app\_server\_min\_size | The minimum size of the auto scale group | `string` | `"0"` | no |
| asg\_app\_server\_os | Name of AMI to use for the instance, give windows or linux as a value in service layer | `string` | `"windows2019"` | no |
| asg\_app\_server\_placement\_group | The name of the placement group into which you'll launch your instances, if any | `string` | `""` | no |
| asg\_app\_server\_placement\_tenancy | The tenancy of the instance. Valid values are 'default' or 'dedicated' | `string` | `"default"` | no |
| asg\_app\_server\_platform | Name of AMI to use for the instance, give windows or linux as a value in service layer | `string` | `"windows"` | no |
| asg\_app\_server\_protect\_from\_scale\_in | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| asg\_app\_server\_recreate\_asg\_when\_lc\_changes | Whether to recreate an autoscaling group when launch configuration changes | `bool` | `false` | no |
| asg\_app\_server\_root\_block\_device | Customize details about the root block device of the instance | `list(map(string))` | `[]` | no |
| asg\_app\_server\_service\_linked\_role\_arn | The ARN of the service-linked role that the ASG will use to call other AWS services. | `string` | `""` | no |
| asg\_app\_server\_spot\_price | The price to use for reserving spot instances | `string` | `""` | no |
| asg\_app\_server\_suspended\_processes | A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly. | `list(string)` | `[]` | no |
| asg\_app\_server\_tags\_as\_map | A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws\_autoscaling\_group requires. | `map(string)` | `{}` | no |
| asg\_app\_server\_target\_group\_arns | A list of aws\_alb\_target\_group ARNs, for use with Application Load Balancing | `list(string)` | `[]` | no |
| asg\_app\_server\_termination\_policies | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default | `list(string)` | <pre>[<br>  "Default"<br>]</pre> | no |
| asg\_app\_server\_use\_ansible\_configuration | Allows set up to call ansible jobtempalte from SSM association | `bool` | `false` | no |
| asg\_app\_server\_user\_data | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `null` | no |
| asg\_app\_server\_user\_data\_base64 | Can be used instead of user\_data to pass base64-encoded binary data directly. Use this instead of user\_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | `string` | `null` | no |
| asg\_app\_server\_wait\_for\_elb\_capacity | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min\_elb\_capacity behavior. | `number` | `null` | no |
| asg\_config\_powershell\_script | ps filename in s3 bucket used to call ansible api | `string` | `"bootstrap.ps1"` | no |
| asg\_config\_ssm\_documentname | SSM docuement name for asf configuration | `string` | `"AWS-RunRemoteScript"` | no |
| asg\_enabled\_metrics | A list of metrics to collect. The allowed values are `GroupMinSize`, `GroupMaxSize`, `GroupDesiredCapacity`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupTerminatingInstances`, `GroupTotalInstances` | `list(string)` | <pre>[<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupDesiredCapacity",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupTerminatingInstances",<br>  "GroupTotalInstances"<br>]</pre> | no |
| asg\_wait\_for\_capacity\_timeout | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior | `string` | `"10m"` | no |
| asg\_web\_server\_ansible\_extra\_var | Ansible webserver extravar | `string` | `""` | no |
| asg\_web\_server\_ansible\_extra\_var\_parameter\_name | Ansible webserver asg extra var parameter name | `string` | `"/ansible/webserver/extravar"` | no |
| asg\_web\_server\_ansible\_extra\_var\_parameter\_policy\_name | Ansible webserver asg extra var parameter name | `string` | `"asg-webserver-ansible-extravar-parameter-store-policy"` | no |
| asg\_web\_server\_ansible\_jobtemplateid | Ansible webserver asg jobtemplate name pmi-app-<project_code>-<environment>-ansible-job-template | `string` | `""` | no |
| asg\_web\_server\_asg\_name | Creates a unique name for autoscaling group beginning with the specified prefix | `string` | `""` | no |
| asg\_web\_server\_associate\_public\_ip\_address | Associate a public ip address with an instance in a VPC | `bool` | `false` | no |
| asg\_web\_server\_association\_name | SSM Association name for asg webserver | `string` | `"asg-web-server-association-ansible-config"` | no |
| asg\_web\_server\_association\_target\_tag | Target tag key value for ssm association for asg webserver | `map(string)` | `{}` | no |
| asg\_web\_server\_backup\_plan | A tag for back up plan that needs to be specified in app server layer | `string` | `"default"` | no |
| asg\_web\_server\_count | Number of autoscaling group in web layer | `number` | `0` | no |
| asg\_web\_server\_create\_asg | Whether to create autoscaling group | `bool` | `true` | no |
| asg\_web\_server\_create\_asg\_with\_initial\_lifecycle\_hook | Create an ASG with initial lifecycle hook | `bool` | `false` | no |
| asg\_web\_server\_create\_lc | Whether to create launch configuration | `bool` | `true` | no |
| asg\_web\_server\_default\_cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `300` | no |
| asg\_web\_server\_desired\_capacity | The number of Amazon EC2 instances that should be running in the group | `string` | `"0"` | no |
| asg\_web\_server\_ebs\_block\_device | Additional EBS block devices to attach to the instance | `list(map(string))` | `[]` | no |
| asg\_web\_server\_ebs\_optimized | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| asg\_web\_server\_enable\_monitoring | Enables/disables detailed monitoring. This is enabled by default. | `bool` | `true` | no |
| asg\_web\_server\_ephemeral\_block\_device | Customize Ephemeral (also known as 'Instance Store') volumes on the instance | `list(map(string))` | `[]` | no |
| asg\_web\_server\_force\_delete | Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling | `bool` | `false` | no |
| asg\_web\_server\_health\_check\_grace\_period | Time (in seconds) after instance comes into service before checking health | `number` | `300` | no |
| asg\_web\_server\_health\_check\_type | Controls how health checking is done. Values are - EC2 and ELB | `string` | `"EC2"` | no |
| asg\_web\_server\_iam\_policy\_arn | List of policies to be assigned to the asg web server | `map(string)` | `{}` | no |
| asg\_web\_server\_image\_id | The EC2 image ID to launch | `string` | `""` | no |
| asg\_web\_server\_initial\_lifecycle\_hook\_default\_result | Defines the action the Auto Scaling group should take when the lifecycle hook timeout elapses or if an unexpected failure occurs. The value for this parameter can be either CONTINUE or ABANDON | `string` | `"ABANDON"` | no |
| asg\_web\_server\_initial\_lifecycle\_hook\_heartbeat\_timeout | Defines the amount of time, in seconds, that can elapse before the lifecycle hook times out. When the lifecycle hook times out, Auto Scaling performs the action defined in the DefaultResult parameter | `string` | `"60"` | no |
| asg\_web\_server\_initial\_lifecycle\_hook\_lifecycle\_transition | The instance state to which you want to attach the initial lifecycle hook | `string` | `""` | no |
| asg\_web\_server\_initial\_lifecycle\_hook\_name | The name of initial lifecycle hook | `string` | `""` | no |
| asg\_web\_server\_initial\_lifecycle\_hook\_notification\_metadata | Contains additional information that you want to include any time Auto Scaling sends a message to the notification target | `string` | `""` | no |
| asg\_web\_server\_initial\_lifecycle\_hook\_notification\_target\_arn | The ARN of the notification target that Auto Scaling will use to notify you when an instance is in the transition state for the lifecycle hook. This ARN target can be either an SQS queue or an SNS topic | `string` | `""` | no |
| asg\_web\_server\_initial\_lifecycle\_hook\_role\_arn | The ARN of the IAM role that allows the Auto Scaling group to publish to the specified notification target | `string` | `""` | no |
| asg\_web\_server\_instance\_type | The size of instance to launch | `string` | `"t2.micro"` | no |
| asg\_web\_server\_join\_domain | whether asg webserver will join PMINTL.NET domain | `bool` | `false` | no |
| asg\_web\_server\_key\_name | The key name that should be used for the instance | `string` | `""` | no |
| asg\_web\_server\_launch\_configuration | The name of the launch configuration to use (if it is created outside of this module) | `string` | `""` | no |
| asg\_web\_server\_lc\_name | Creates a unique name for launch configuration beginning with the specified prefix | `string` | `""` | no |
| asg\_web\_server\_load\_balancers | A list of elastic load balancer names to add to the autoscaling group names | `list(string)` | `[]` | no |
| asg\_web\_server\_max\_instance\_lifetime | The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds. | `number` | `0` | no |
| asg\_web\_server\_max\_size | The maximum size of the auto scale group | `string` | `"0"` | no |
| asg\_web\_server\_metrics\_granularity | The granularity to associate with the metrics to collect. The only valid value is 1Minute | `string` | `"1Minute"` | no |
| asg\_web\_server\_min\_elb\_capacity | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | `number` | `0` | no |
| asg\_web\_server\_min\_size | The minimum size of the auto scale group | `string` | `"0"` | no |
| asg\_web\_server\_os | Name of AMI to use for the instance, give windows or linux as a value in service layer | `string` | `"windows2019"` | no |
| asg\_web\_server\_placement\_group | The name of the placement group into which you'll launch your instances, if any | `string` | `""` | no |
| asg\_web\_server\_placement\_tenancy | The tenancy of the instance. Valid values are 'default' or 'dedicated' | `string` | `"default"` | no |
| asg\_web\_server\_platform | Name of AMI to use for the instance, give windows or linux as a value in service layer | `string` | `"windows"` | no |
| asg\_web\_server\_protect\_from\_scale\_in | Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events. | `bool` | `false` | no |
| asg\_web\_server\_recreate\_asg\_when\_lc\_changes | Whether to recreate an autoscaling group when launch configuration changes | `bool` | `false` | no |
| asg\_web\_server\_root\_block\_device | Customize details about the root block device of the instance | `list(map(string))` | `[]` | no |
| asg\_web\_server\_service\_linked\_role\_arn | The ARN of the service-linked role that the ASG will use to call other AWS services. | `string` | `""` | no |
| asg\_web\_server\_spot\_price | The price to use for reserving spot instances | `string` | `""` | no |
| asg\_web\_server\_suspended\_processes | A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly. | `list(string)` | `[]` | no |
| asg\_web\_server\_tags\_as\_map | A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws\_autoscaling\_group requires. | `map(string)` | `{}` | no |
| asg\_web\_server\_target\_group\_arns | A list of aws\_alb\_target\_group ARNs, for use with Application Load Balancing | `list(string)` | `[]` | no |
| asg\_web\_server\_termination\_policies | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default | `list(string)` | <pre>[<br>  "Default"<br>]</pre> | no |
| asg\_web\_server\_use\_ansible\_configuration | Allows set up to call ansible jobtempalte from SSM association | `bool` | `false` | no |
| asg\_web\_server\_user\_data | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user\_data\_base64 instead. | `string` | `null` | no |
| asg\_web\_server\_user\_data\_base64 | Can be used instead of user\_data to pass base64-encoded binary data directly. Use this instead of user\_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption. | `string` | `null` | no |
| asg\_web\_server\_wait\_for\_elb\_capacity | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min\_elb\_capacity behavior. | `number` | `null` | no |
| cloudwatchagent\_policy\_arn | cloudwatch agent policy arn | `string` | `"arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"` | no |
| db\_port | Port that database should listen to. Used for SecurityGroups and instance config | `string` | `"1433"` | no |
| db\_server\_allowed\_ips\_for\_ssh\_rdp | List of IP addresses that have SSH or RDP access to the instance | `list(string)` | `[]` | no |
| db\_server\_allowed\_ips\_for\_winrm | List of IP addresses that have winrm access to the instance | `list(string)` | `[]` | no |
| db\_server\_auto\_recovery\_alarm | Create auto recovery alarm for db instances | `bool` | `false` | no |
| db\_server\_create\_s3\_backup\_bucket | Create S3 bucket for backups | `bool` | `true` | no |
| db\_server\_ec2\_backup\_plan | A tag for back up plan that needs to be specified | `string` | `"default"` | no |
| db\_server\_ec2\_ebs\_volume\_device | EBS volumes to be created that needs to be attached to the instance | `map(map(string))` | `{}` | no |
| db\_server\_ec2\_iam\_policy\_arn | List of policies to be assigned to the EC2 Instance | `map(string)` | `{}` | no |
| db\_server\_ec2\_instance\_count | Number of instances to launch in database server layer | `number` | `0` | no |
| db\_server\_ec2\_maintenance\_window | The type of instance to start in database server layer | `string` | `"SUN_00"` | no |
| db\_server\_ec2\_root\_volume\_size | Volume size for the root block device of the instance | `string` | `"70"` | no |
| db\_server\_ec2\_tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| db\_server\_ec2\_volume\_tags | A mapping of tags to assign to the devices created by the instance at launch time | `map(string)` | `{}` | no |
| db\_server\_instance\_type | The type of instance to start | `string` | `"r5.large"` | no |
| db\_server\_join\_domain | whether db server will join PMINTL.NET domain | `bool` | `false` | no |
| db\_server\_name | Name to be used on all resources as prefix in db layer | `string` | `""` | no |
| db\_server\_root\_volume\_iops | Volume iops for the root block device of the instance | `string` | `"0"` | no |
| db\_server\_root\_volume\_throughput | Volume throughput for the root block device of the instance | `string` | `"0"` | no |
| db\_server\_root\_volume\_type | Volume type for the root block device of the instance | `string` | `"gp3"` | no |
| db\_server\_sql\_backup\_volume\_iops | Volume iops for the SQL Backups | `string` | `"0"` | no |
| db\_server\_sql\_backup\_volume\_size | Volume size for the SQL Backups | `string` | `"10"` | no |
| db\_server\_sql\_backup\_volume\_throughput | Volume throughput for the SQL Backups | `string` | `"0"` | no |
| db\_server\_sql\_backup\_volume\_type | Volume type for the SQL Backups | `string` | `"gp3"` | no |
| db\_server\_sql\_data\_volume\_iops | Volume iops for the SQL Data | `string` | `"0"` | no |
| db\_server\_sql\_data\_volume\_size | Volume size for the SQL Data | `string` | `"10"` | no |
| db\_server\_sql\_data\_volume\_throughput | Volume iops for the SQL Data | `string` | `"0"` | no |
| db\_server\_sql\_data\_volume\_type | Volume type for the SQL Data | `string` | `"gp3"` | no |
| db\_server\_sql\_edition | SQl server version - enterprise or standard | `string` | `"standard"` | no |
| db\_server\_sql\_logs\_volume\_iops | Volume iops for the SQL Logs | `string` | `"0"` | no |
| db\_server\_sql\_logs\_volume\_size | Volume size for the SQL Logs | `string` | `"10"` | no |
| db\_server\_sql\_logs\_volume\_throughput | Volume throughput for the SQL Logs | `string` | `"0"` | no |
| db\_server\_sql\_logs\_volume\_type | Volume type for the SQL Logs | `string` | `"gp3"` | no |
| db\_server\_sql\_temp\_volume\_iops | Volume iops for the SQL Tempdb | `string` | `"0"` | no |
| db\_server\_sql\_temp\_volume\_size | Volume size for the SQL Tempdb | `string` | `"10"` | no |
| db\_server\_sql\_temp\_volume\_throughput | Volume throughput for the SQL Tempdb | `string` | `"0"` | no |
| db\_server\_sql\_temp\_volume\_type | Volume type for the SQL Tempdb | `string` | `"gp3"` | no |
| db\_server\_sql\_version | SQl server version - 2016 or 2019 | `string` | `"2016"` | no |
| db\_server\_subnet\_ids | Number of instances to launch in database layer | `list(string)` | `[]` | no |
| db\_server\_user\_data | Contents of EC2 user-data | `string` | `""` | no |
| domain\_join\_lambda\_config | Lambda configurations for domain join | `map(string)` | `{}` | no |
| ec2\_launch\_vpc\_group | Specifying vpc mode tag for the EC2 Instance. example: hybrid/lands/greenfield etc | `string` | n/a | yes |
| env | Environment i.e. dev/qa/prd | `string` | n/a | yes |
| hostname\_lambda\_concurrent\_executions | Reserved concurrency for hostname lambda | `number` | `1` | no |
| hostname\_lambda\_handler | lambda handler | `string` | `"hostname.lambda_handler"` | no |
| hostname\_lambda\_memory\_size | Lambda memory size in mb | `number` | `200` | no |
| hostname\_lambda\_runtime | lambda runtime | `string` | `"python3.8"` | no |
| hostname\_lambda\_timeout | Lambda timeout in seconds | `number` | `50` | no |
| hostname\_lambda\_zip\_filename | hostname lambda zip filename | `string` | `"hostname.zip"` | no |
| instance\_autorecovery\_alarm\_evaluation\_period | ec2 instance autorecovery evaluation period | `string` | `"3"` | no |
| instance\_autorecovery\_alarm\_period | ec2 instance autorecovery period(seconds) | `string` | `"60"` | no |
| instance\_autorecovery\_alarm\_threshold | ec2 instance autorecovery threshold | `string` | `"1"` | no |
| key\_name | The key name to use for the instance | `string` | n/a | yes |
| kms\_arn\_for\_secret | CMK KMS arn for secret manager | `string` | `""` | no |
| product\_code | Unique identifier across the whole DEEP platform | `string` | n/a | yes |
| service\_account\_secret | service account secret | `map(string)` | `{}` | no |
| ssm\_policy\_arn | ssm policy arn | `string` | `"arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"` | no |
| vpc\_id | vpc id | `string` | n/a | yes |
| web\_server\_allowed\_ips\_for\_ssh\_rdp | List of IP addresses that have SSH or RDP access to the instance | `list(string)` | `[]` | no |
| web\_server\_allowed\_ips\_for\_winrm | List of IP addresses that have winrm access to the instance | `list(string)` | `[]` | no |
| web\_server\_auto\_recovery\_alarm | Create auto recovery alarm for app instances | `bool` | `false` | no |
| web\_server\_ec2\_backup\_plan | A tag for back up plan that needs to be specified in web server layer | `string` | `"default"` | no |
| web\_server\_ec2\_ebs\_volume\_device | EBS volumes to be created that needs to be attached to the instance | `map(map(string))` | <pre>{<br>  "device1": {<br>    "device_name": "/dev/sdf",<br>    "volume_size": "20"<br>  }<br>}</pre> | no |
| web\_server\_ec2\_iam\_policy\_arn | List of policies to be assigned to the EC2 Instance in web server layer | `map(string)` | `{}` | no |
| web\_server\_ec2\_instance\_count | Number of instances to launch in web server layer | `number` | `0` | no |
| web\_server\_ec2\_maintenance\_window | The type of instance to start in web server layer | `string` | `"SUN_00"` | no |
| web\_server\_ec2\_root\_volume\_size | Volume size for the root block device of the instance in web server layer | `string` | `""` | no |
| web\_server\_ec2\_tags | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| web\_server\_ec2\_volume\_tags | A mapping of tags to assign to the devices created by the instance at launch time | `map(string)` | `{}` | no |
| web\_server\_instance\_type | The type of instance to start in application layer | `string` | `"t2.micro"` | no |
| web\_server\_join\_domain | whether web server will join PMINTL.NET domain | `bool` | `false` | no |
| web\_server\_name | Name to be used on all resources as prefix in web layer | `string` | `""` | no |
| web\_server\_os | Name of AMI to use for the instance, give windows or linux as a value in service layer | `string` | `"windows2019"` | no |
| web\_server\_platform | Name of AMI to use for the instance, give windows or linux as a value in application layer | `string` | `"windows"` | no |
| web\_server\_subnet\_ids | Number of instances to launch in application layer | `list(string)` | `[]` | no |
| web\_server\_user\_data | Contents of EC2 user-data | `string` | `""` | no |

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
