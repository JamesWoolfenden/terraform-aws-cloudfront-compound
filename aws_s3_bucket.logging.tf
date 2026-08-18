# tfsec:ignore:AWS077
resource "aws_s3_bucket" "logging" {
  # holden:ignore:HLD_AWS_144: this is the terminal logging destination bucket; pointing access logging at itself is a self-referential AWS anti-pattern, same reasoning as checkov:skip=CKV_AWS_18 below
  bucket = "${var.bucket_name}-logging"


  lifecycle {
    ignore_changes = [tags]
  }
}
resource "aws_s3_bucket_acl" "logging" {
  bucket = aws_s3_bucket.logging.bucket
  acl    = "log-delivery-write"
}
resource "aws_s3_bucket_server_side_encryption_configuration" "logging" {
  bucket = aws_s3_bucket.logging.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key.id
    }
  }

}
resource "aws_s3_bucket_versioning" "logging" {
  bucket = aws_s3_bucket.logging.id
  versioning_configuration {
    status     = var.versioning ? "Enabled" : "Suspended"
    mfa_delete = "Disabled"
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "logging" {
  bucket = aws_s3_bucket.logging.id

  rule {
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
    status = "Enabled"
    id     = "cleanout"

    expiration {
      days                         = 31
      expired_object_delete_marker = false
    }

    noncurrent_version_expiration {
      noncurrent_days = 31
    }

  }
}
