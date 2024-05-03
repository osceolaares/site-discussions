module "cdn" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.94.0"

  namespace                   = "oares"
  stage                       = "use1"
  name                        = "cdn"
  aliases                     = [local.hostname]
  dns_alias_enabled           = true
  website_enabled             = true
  s3_website_password_enabled = true
  allow_ssl_requests_only     = false
  price_class                 = "PriceClass_All"
  default_ttl                 = 86400
  min_ttl                     = 3600
  max_ttl                     = 2592000
  minimum_protocol_version    = "TLSv1.2_2021"
  custom_error_response = [
    {
      error_caching_min_ttl = null
      error_code            = 404
      response_code         = 200
      response_page_path    = "/404.html"
    }
  ]
  parent_zone_id      = data.aws_route53_zone.this.zone_id
  acm_certificate_arn = data.aws_acm_certificate.this.arn
}

locals {
  hostname = join(".", compact([var.host_name, var.domain_name]))
}