data "aws_iam_policy_document" "b" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.b.arn}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        module.cloudfront.identity.iam_arn,
      ]
    }
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.b.arn,
    ]

    principals {
      type = "AWS"

      identifiers = [
        module.cloudfront.identity.iam_arn,
      ]
    }
  }
}
