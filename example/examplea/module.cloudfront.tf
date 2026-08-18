# holden:ignore:HLD_TF_026: local relative source is intentional here — this example exercises the module under active development in this same repo, not a published version
module "cloudfront" {
  source            = "../../"
  versioning        = var.versioning
  bucket_name       = var.bucket_name
  geo_restrictions  = var.geo_restrictions
  buckets           = [aws_s3_bucket.b, aws_s3_bucket.routed]
  default_behaviour = var.default_behaviour
  behaviours        = var.behaviours
  kms_key           = aws_kms_key.encryption

  custom_error_responses = [
    {
      error_code         = 404
      response_code      = 404
      response_page_path = "/404.html"
    }
  ]
}
