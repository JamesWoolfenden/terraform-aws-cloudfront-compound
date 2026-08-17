resource "aws_s3_bucket" "b" {
  # tfsec:ignore:AWS002
  # tfsec:ignore:AWS077
  # checkov:skip=CKV_AWS_144: ADD REASON
  # checkov:skip=CKV_AWS_145: v4 legacy
  # checkov:skip=CKV_AWS_19: v4 legacy
  # checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  # holden:ignore:HLD_AWS_144: access logging not required for this example bucket, same as checkov:skip=CKV_AWS_18 above
  # checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  # checkov:skip=CKV_AWS_52: "Ensure S3 bucket has MFA delete enabled"
  # checkov:skip=CKV2_AWS_41: Not required
  # checkov:skip=CKV2_AWS_62: Event notifications not required for this bucket
  # checkov:skip=CKV2_AWS_61: Lifecycle managed externally
  # holden:ignore:HLD_AWS_153: lifecycle managed externally, same as checkov:skip=CKV2_AWS_61 above
  bucket = var.bucket_name

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_s3_bucket_public_access_block" "b" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_server_side_encryption_configuration" "b" {
  bucket = aws_s3_bucket.b.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.encryption.id
    }
  }

}
resource "aws_s3_bucket_versioning" "b" {
  bucket = aws_s3_bucket.b.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}
resource "aws_s3_bucket_acl" "b" {
  bucket = aws_s3_bucket.b.bucket
  acl    = "private"
}
