output "cloudFrontDistributionID" {
  value       = module.cdn.cf_id
  description = "AWS Cloudfront Distribuion ID"
}

output "s3Bucket" {
  value       = module.website.bucket_id
  description = "AWS S3 Bucket name"
}

output "hostname" {
  value       = module.cdn.aliases[0]
  description = "Base hostname used for Cloudfront Distibution"
}
