

resource "aws_s3_bucket" "routed" {
  # checkov:skip=CKV2_AWS_6: ADD REASON
  # tfsec:ignore:AWS002
  # tfsec:ignore:AWS077
  # checkov:skip=CKV_AWS_144: ADD REASON
  # checkov:skip=CKV_AWS_145: v4 legacy
  # checkov:skip=CKV_AWS_19: v4 legacy
  # checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  # checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  # checkov:skip=CKV_AWS_52: "Ensure S3 bucket has MFA delete enabled"
  # checkov:skip=CKV2_AWS_41: Not required
  bucket = "anotherprivatemybucketrouted"

  lifecycle {
    ignore_changes = [tags]
  }
}



resource "aws_s3_bucket_server_side_encryption_configuration" "routed" {
  bucket = aws_s3_bucket.routed.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.example.id
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
