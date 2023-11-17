
locals {
  ses_domain_name = format("%s-%s.%s", var.product_code, var.environment, var.ses_domain)
  ses_tags = {
    ProductCode = var.product_code,
    Environment = var.environment
  }
}
