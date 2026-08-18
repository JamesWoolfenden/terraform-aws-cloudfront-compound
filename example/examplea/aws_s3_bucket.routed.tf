resource "aws_s3_bucket" "routed" {
  # holden:ignore:HLD_AWS_144: access logging not required for this example bucket, same as checkov:skip=CKV_AWS_18 above
  # holden:ignore:HLD_AWS_153: lifecycle managed externally, same as checkov:skip=CKV2_AWS_61 above
  bucket = "anotherprivatemybucketrouted"

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_s3_bucket_public_access_block" "routed" {
  bucket = aws_s3_bucket.routed.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "routed" {
  bucket = aws_s3_bucket.routed.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.encryption.id
    }
  }

}

resource "aws_s3_bucket_versioning" "routed" {
  bucket = aws_s3_bucket.routed.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_acl" "routed" {
  bucket = aws_s3_bucket.routed.bucket
  acl    = "private"
}
