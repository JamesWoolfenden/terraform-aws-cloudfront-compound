resource "aws_s3_bucket" "b" {
  #checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  #checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  #checkov:skip=CKV_AWS_52: "Ensure S3 bucket has MFA delete enabled"
  bucket = var.bucket_name
  acl    = "private"
  versioning {
    enabled    = false
    mfa_delete = false
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }

  tags = var.common_tags
}
