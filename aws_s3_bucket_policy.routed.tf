resource "aws_s3_bucket_policy" "routed" {
  bucket = aws_s3_bucket.routed.id
  policy = data.aws_iam_policy_document.routed.json
}
