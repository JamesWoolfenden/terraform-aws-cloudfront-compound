output "distribution" {
  description = "The CloudFront distribution resource."
  value       = aws_cloudfront_distribution.s3_distribution
}
output "identity" {
  description = "The CloudFront origin access identity resource used to grant CloudFront access to the origin S3 buckets."
  value       = aws_cloudfront_origin_access_identity.site
}
output "logging" {
  description = "The S3 bucket resource that receives CloudFront access logs."
  value       = aws_s3_bucket.logging
}
