module "ses" {
  source              = "./modules/terraform-aws-cm-ses"
  route53_acn_zone_id = data.terraform_remote_state.app-baseline.outputs.route53_acn_zone_id
  environment         = var.environment
  product_code        = var.product_code
}
