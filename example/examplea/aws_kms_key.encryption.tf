resource "aws_kms_key" "encryption" {
  #checkov:skip=CKV2_AWS_64: "KMS key policy not required for example"
  # holden:ignore:HLD_AWS_214: KMS key policy not required for example, same as checkov:skip=CKV2_AWS_64 above
  # holden:ignore:HLD_TF_041: this is ephemeral example/test infrastructure that must remain destroyable in CI
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "encryption" {
  name          = "alias/${var.bucket_name}-encryption"
  target_key_id = aws_kms_key.encryption.key_id
}
