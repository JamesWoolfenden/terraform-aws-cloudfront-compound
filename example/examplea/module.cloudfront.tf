module "cloudfront" {
  source            = "../../"
  versioning        = var.versioning
  bucket_name       = var.bucket_name
  geo_restrictions  = var.geo_restrictions
  buckets           = [aws_s3_bucket.b, aws_s3_bucket.routed]
  default_behaviour = var.default_behaviour
  behaviours        = var.behaviours
  kms_key           = aws_kms_key.example
}
