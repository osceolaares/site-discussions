output "cloudFrontDistributionID" {
  value = module.cdn.cf_id
}

output "URL" {
  value = format("s3://%s?region=%s", module.cdn.s3_bucket, data.aws_region.current.name)
}
