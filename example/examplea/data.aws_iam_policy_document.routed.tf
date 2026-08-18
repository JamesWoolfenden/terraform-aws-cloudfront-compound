data "aws_iam_policy_document" "routed" {
  # checkov:skip=CKV_AWS_356: IAM policy requires broad access for this module to function
  # checkov:skip=CKV_AWS_290: IAM policy requires broad write access for this module to function
  # checkov:skip=CKV_AWS_355: IAM policy requires wildcard resource for this module to function
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
}
