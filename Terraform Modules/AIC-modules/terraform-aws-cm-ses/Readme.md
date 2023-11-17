## Requirements

The following requirements are needed by this module:

- terraform (>= 0.13, < 0.14)

- aws (>= 3.5.0, < 4.0)

## Providers

The following providers are used by this module:

- aws (>= 3.5.0, < 4.0)

## Modules

No Modules.

## Resources

The following resources are used by this module:

- [aws_iam_access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key)
- [aws_iam_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group)
- [aws_iam_group_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)
- [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)
- [aws_iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)
- [aws_iam_user_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership)
- [aws_route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)
- [aws_ses_domain_dkim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim)
- [aws_ses_domain_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity)
- [aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)

## Required Inputs

The following input variables are required:

### environment

Description: Environment i.e. dev/qa/prd

Type: `string`

### product\_code

Description: Unique identifier across the whole DEEP platform

Type: `string`

### route53\_acn\_zone\_id

Description: Route53 public zone id from baseline

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### enable\_verification

Description: Enabling domain verification for SES

Type: `bool`

Default: `true`

### ses\_domain

Description: domain for SES

Type: `string`

Default: `"eu-west-1.aws.pmicloud.biz"`

## Outputs

The following outputs are exported:

### ssm\_password\_path

Description: Path for ssm password value

### ssm\_user\_path

Description: Path for ssm username value
