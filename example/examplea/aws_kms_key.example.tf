resource "aws_kms_key" "example" {
  #checkov:skip=CKV2_AWS_64: "KMS key policy not required for example"
  enable_key_rotation = true
}
