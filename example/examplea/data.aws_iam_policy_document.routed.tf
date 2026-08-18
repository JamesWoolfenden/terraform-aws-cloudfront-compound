data "aws_iam_policy_document" "routed" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.routed.arn}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        module.cloudfront.identity.iam_arn,
      ]
    }
    sid = 1
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.routed.arn,
    ]

    principals {
      type = "AWS"

      identifiers = [
        module.cloudfront.identity.iam_arn,
      ]
    }
    sid = 2
  }

  statement {
    sid       = "DenyInsecureTransport"
    effect    = "Deny"
    actions   = ["s3:*"]
    resources = [aws_s3_bucket.routed.arn, "${aws_s3_bucket.routed.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}
