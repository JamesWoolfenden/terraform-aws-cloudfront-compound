output "distribution" {
  description = "The CloudFront distribution resource."
  value       = module.cloudfront.distribution
}
output "identity" {
  description = "The CloudFront origin access identity resource used to grant CloudFront access to the origin S3 buckets."
  value       = module.cloudfront.identity
}
output "logging" {
  description = "The S3 bucket resource that receives CloudFront access logs."
  value       = module.cloudfront.logging
}
