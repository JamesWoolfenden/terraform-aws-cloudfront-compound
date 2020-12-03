resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id
  policy = data.aws_iam_policy_document.b.json
}
