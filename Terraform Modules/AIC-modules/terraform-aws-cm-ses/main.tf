resource "aws_ses_domain_identity" "this" {
  domain = local.ses_domain_name
}

resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

resource "aws_route53_record" "this_verification" {
  count   = var.enable_verification ? 1 : 0
  zone_id = var.route53_acn_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.this.id}"
  type    = "TXT"
  ttl     = "1800"
  records = [aws_ses_domain_identity.this.verification_token]

  depends_on = [
    aws_ses_domain_identity.this
  ]
}

resource "aws_route53_record" "this_dkim" {
  count   = 3
  zone_id = var.route53_acn_zone_id
  name    = "${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "1800"
  records = ["${element(aws_ses_domain_dkim.this.dkim_tokens, count.index)}.dkim.amazonses.com"]

  depends_on = [
    aws_ses_domain_dkim.this
  ]
}


resource "aws_ses_domain_mail_from" "ses_domain_mail_from" {
  domain           = aws_ses_domain_identity.this.domain
  mail_from_domain = "noreply.${aws_ses_domain_identity.this.domain}"
}

# Example Route53 MX record
resource "aws_route53_record" "ses_domain_mail_from_mx" {
  zone_id = var.route53_acn_zone_id
  name    = aws_ses_domain_mail_from.ses_domain_mail_from.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.eu-west-1.amazonses.com"] # Change to the region in which `aws_ses_domain_identity.example` is created
}

# Example Route53 TXT record for SPF
resource "aws_route53_record" "ses_domain_mail_from_txt" {
  zone_id = var.route53_acn_zone_id
  name    = aws_ses_domain_mail_from.ses_domain_mail_from.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}