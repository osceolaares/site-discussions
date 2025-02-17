resource "aws_route53_zone" "this" {
  name          = var.domain_name
  comment       = var.comment
  force_destroy = false

  lifecycle {
    ignore_changes = [vpc]
  }
}

module "website" {
  source  = "cloudposse/s3-bucket/aws"
  version = "4.10.0"

  bucket_name         = aws_route53_zone.this.name
  s3_object_ownership = "BucketOwnerEnforced"
  versioning_enabled  = false
  context             = module.this.context
  website_configuration = [
    {
      index_document = "index.html"
      error_document = "/404.html"
      routing_rules  = null
    }
  ]
}

module "acm_certificate" {
  source  = "cloudposse/acm-request-certificate/aws"
  version = "0.18.0"

  domain_name                       = aws_route53_zone.this.name
  zone_id                           = aws_route53_zone.this.id
  process_domain_validation_options = true
  ttl                               = "300"
  subject_alternative_names         = [join(".", ["*", aws_route53_zone.this.name])]
}

locals {
  caa_report_recipient = can(regex("@", var.caa_report_recipient)) ? var.caa_report_recipient : "${var.caa_report_recipient}@${aws_route53_zone.this.name}"
  tls_report_recipient = can(regex("@", var.tls_report_recipient)) ? var.tls_report_recipient : "${var.tls_report_recipient}@${aws_route53_zone.this.name}"
}
