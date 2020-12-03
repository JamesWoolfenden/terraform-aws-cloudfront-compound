module "cloudfront" {
  source            = "../../"
  versioning        = var.versioning
  common_tags       = var.common_tags
  bucket_name       = var.bucket_name
  geo_restrictions  = var.geo_restrictions
  buckets           = [aws_s3_bucket.b, aws_s3_bucket.routed]
  default_behaviour = var.default_behaviour
  behaviours        = var.behaviours
}
