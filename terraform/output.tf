output "distributionID" {
  value = module.cdn.cf_id
}

output "bucket" {
  value = module.cdn.s3_bucket
}