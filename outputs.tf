
output "distribution" {
  value = aws_cloudfront_distribution.s3_distribution
}

output "identity" {
  value = aws_cloudfront_origin_access_identity.site
}
