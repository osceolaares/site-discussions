module "cdn" {
  source  = "cloudposse/cloudfront-cdn/aws"
  version = "1.2.0"

  name                = "cdn"
  origin_domain_name  = module.website.bucket_website_domain
  aliases             = [local.hostname, local.mta_sts]
  dns_aliases_enabled = true
  compress            = true
  price_class         = "PriceClass_All"
  default_ttl         = 86400
  min_ttl             = 3600
  max_ttl             = 2592000
  parent_zone_id      = aws_route53_zone.this.id
  acm_certificate_arn = module.acm_certificate.arn
  context             = module.this.context
  forward_headers = [
    "Access-Control-Request-Headers",
    "Access-Control-Request-Method",
    "Origin",
  ]
  custom_error_response = [
    {
      error_caching_min_ttl = null
      error_code            = 404
      response_code         = 200
      response_page_path    = "/404.html"
    }
  ]
}

locals {
  hostname = join(".", compact([var.host_name, aws_route53_zone.this.name]))
  mta_sts  = join(".", ["mta-sts", aws_route53_zone.this.name])
}
