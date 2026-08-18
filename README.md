# terraform-aws-cloudfront-compound

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/workflows/Verify/badge.svg?branch=main)](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-cloudfront-compound.svg)](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-aws-cloudfront-compound.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

Terraform module to provision multiple Origins and multiple routes via behaviors.

The example examplea creates 2 s3 origins and multiple behaviors to different paths, the root points to one bucket and index.html and there are 2 paths path1 which has one file cat.jpg and path2 which has dog.jpg.

## ToDO

This module needs merging with the general cloudfront-s3 one I have, adding in route53 and ssl from ACM. It also needs modifying to support different origins - e.g. api gateway. Ill get around to it...

## Usage

Create a file call **module.cloudfront.tf**:

```terraform
module "cloudfront" {
  source            = "jameswoolfenden/aws/cloudfront-compound"
  versioning        = var.versioning
  bucket_name       = var.bucket_name
  geo_restrictions  = var.geo_restrictions
  buckets           = [aws_s3_bucket.b, aws_s3_bucket.routed]
  default_behaviour = var.default_behaviour
  behaviours        = var.behaviours
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_cloudfront_response_headers_policy.headers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_response_headers_policy) | resource |
| [aws_s3_bucket.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_public_access_block.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_behaviours"></a> [behaviours](#input\_behaviours) | List of ordered cache behavior configurations (path pattern, methods, origin id, forwarded headers/query string/cookies, TTLs, compression, and viewer protocol policy). | `any` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Base name used to derive the CloudFront distribution's associated S3 bucket names (e.g. the logging bucket). | `string` | n/a | yes |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | List of S3 bucket resources used as CloudFront origins; buckets[0] backs the default cache behavior and buckets[1] backs the first ordered cache behavior. | `list(any)` | n/a | yes |
| <a name="input_content_security_policy"></a> [content\_security\_policy](#input\_content\_security\_policy) | Content-Security-Policy response header configuration applied via the CloudFront response headers policy. | `map(any)` | <pre>{<br/>  "content_security_policy": "default-src 'none'; img-src 'self'; script-src 'self'; style-src 'self'; object-src 'none'; frame-ancestors 'none'",<br/>  "override": true<br/>}</pre> | no |
| <a name="input_content_type_options"></a> [content\_type\_options](#input\_content\_type\_options) | X-Content-Type-Options response header configuration applied via the CloudFront response headers policy. | `map(any)` | <pre>{<br/>  "override": true<br/>}</pre> | no |
| <a name="input_default_behaviour"></a> [default\_behaviour](#input\_default\_behaviour) | Default cache behavior configuration for the CloudFront distribution (allowed/cached methods, origin id, forwarded query string/cookies, viewer protocol policy, and TTLs). | `any` | n/a | yes |
| <a name="input_frame_options"></a> [frame\_options](#input\_frame\_options) | X-Frame-Options response header configuration applied via the CloudFront response headers policy. | `map(any)` | <pre>{<br/>  "frame_option": "DENY",<br/>  "override": true<br/>}</pre> | no |
| <a name="input_geo_restrictions"></a> [geo\_restrictions](#input\_geo\_restrictions) | CloudFront geo-restriction configuration; a map with restriction\_type (e.g. none, whitelist, blacklist) and locations (list of ISO 3166-1-alpha-2 country codes). | `any` | n/a | yes |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | KMS key resource used to encrypt the logging S3 bucket via SSE-KMS. | `any` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of the CloudFront response headers policy. | `string` | `"examplea"` | no |
| <a name="input_referrer_policy"></a> [referrer\_policy](#input\_referrer\_policy) | Referrer-Policy response header configuration applied via the CloudFront response headers policy. | `map(any)` | <pre>{<br/>  "override": true,<br/>  "referrer_policy": "same-origin"<br/>}</pre> | no |
| <a name="input_strict_transport_security"></a> [strict\_transport\_security](#input\_strict\_transport\_security) | Strict-Transport-Security (HSTS) response header configuration applied via the CloudFront response headers policy. | <pre>object({<br/>    access_control_max_age_sec = number<br/>    include_subdomains         = bool<br/>    override                   = bool<br/>    preload                    = bool<br/>  })</pre> | <pre>{<br/>  "access_control_max_age_sec": 31536000,<br/>  "include_subdomains": true,<br/>  "override": true,<br/>  "preload": true<br/>}</pre> | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Switch to control versioning | `bool` | n/a | yes |
| <a name="input_viewer_certificate"></a> [viewer\_certificate](#input\_viewer\_certificate) | CloudFront viewer certificate configuration (whether to use the CloudFront default certificate and the minimum TLS protocol version). | `map` | <pre>{<br/>  "cloudfront_default_certificate": false,<br/>  "minimum_protocol_version": "TLSv1.2_2019"<br/>}</pre> | no |
| <a name="input_xss_protection"></a> [xss\_protection](#input\_xss\_protection) | X-XSS-Protection response header configuration applied via the CloudFront response headers policy. | `map(any)` | <pre>{<br/>  "mode_block": true,<br/>  "override": true,<br/>  "protection": true<br/>}</pre> | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_distribution"></a> [distribution](#output\_distribution) | The CloudFront distribution resource. |
| <a name="output_identity"></a> [identity](#output\_identity) | The CloudFront origin access identity resource used to grant CloudFront access to the origin S3 buckets. |
| <a name="output_logging"></a> [logging](#output\_logging) | The S3 bucket resource that receives CloudFront access logs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Policy

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
# apply role — full permissions for terraform apply
resource "aws_iam_policy" "terraform_pike" {
  name_prefix = "terraform_pike"
  path        = "/"
  description = "Pike Autogenerated policy from IAC"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "cloudfront:CreateCloudFrontOriginAccessIdentity",
                "cloudfront:CreateDistribution",
                "cloudfront:CreateDistributionWithTags",
                "cloudfront:CreateResponseHeadersPolicy",
                "cloudfront:DeleteCloudFrontOriginAccessIdentity",
                "cloudfront:DeleteDistribution",
                "cloudfront:DeleteResponseHeadersPolicy",
                "cloudfront:GetCloudFrontOriginAccessIdentity",
                "cloudfront:GetDistribution",
                "cloudfront:GetDistributionConfig",
                "cloudfront:GetResponseHeadersPolicy",
                "cloudfront:ListTagsForResource",
                "cloudfront:UpdateDistribution",
                "cloudfront:UpdateDistributionWithStagingConfig",
                "cloudfront:UpdateResponseHeadersPolicy"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeAccountAttributes"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:DeleteBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketAcl",
                "s3:GetBucketCORS",
                "s3:GetBucketLogging",
                "s3:GetBucketObjectLockConfiguration",
                "s3:GetBucketPolicy",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketTagging",
                "s3:GetBucketVersioning",
                "s3:GetBucketWebsite",
                "s3:GetEncryptionConfiguration",
                "s3:GetLifecycleConfiguration",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:GetReplicationConfiguration",
                "s3:ListAllMyBuckets",
                "s3:ListBucket",
                "s3:PutBucketAcl",
                "s3:PutBucketLogging",
                "s3:PutBucketPublicAccessBlock",
                "s3:PutBucketVersioning",
                "s3:PutEncryptionConfiguration",
                "s3:PutLifecycleConfiguration"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
})
}

# plan role — read-only permissions for terraform plan
resource "aws_iam_policy" "terraform_pike_plan" {
  name_prefix = "terraform_pike_plan"
  path        = "/"
  description = "Pike Autogenerated policy from IAC"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketAcl",
                "s3:GetBucketCORS",
                "s3:GetBucketLogging",
                "s3:GetBucketObjectLockConfiguration",
                "s3:GetBucketPolicy",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketTagging",
                "s3:GetBucketVersioning",
                "s3:GetBucketWebsite",
                "s3:GetEncryptionConfiguration",
                "s3:GetLifecycleConfiguration",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:GetReplicationConfiguration",
                "s3:ListBucket"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
})
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Related Projects

Check out these related projects.

- [terraform-aws-s3](https://github.com/jameswoolfenden/terraform-aws-s3) - S3 buckets

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/issues) to report any bugs or file feature requests.

## Copyrights

Copyright 2021-2026 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
