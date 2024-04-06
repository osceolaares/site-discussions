data "aws_route53_zone" "this" {
  name = var.domain_name
}

data "aws_acm_certificate" "this" {
  domain      = var.domain_name
  types       = ["AMAZON_ISSUED"]
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_s3_bucket" "this" {
  bucket = format("%s.%s", var.host_name, var.domain_name)
}
