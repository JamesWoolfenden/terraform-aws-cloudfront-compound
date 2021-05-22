# terraform-aws-cloudfront-compound

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-cloudfront-compound.svg)](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-aws-cloudfront-compound.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/JamesWoolfenden/terraform-aws-cloudfront-compound/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-cloudfront-compound&benchmark=CIS+AWS+V1.2)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/jameswoolfenden/terraform-aws-cloudfront-compound/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-cloudfront-compound&benchmark=INFRASTRUCTURE+SECURITY)

Terraform module to provision multiple Origins and multiple routes via behaviors.

The example examplea creates 2 s3 origins and multiple behaviors to different paths, the root points to one bucket and index.html and theres are 2 paths path1 which has one file cat.jpg and path2 which has dog.jpg.

## ToDO

This module needs merging with the general cloudfront-s3 one I have, adding in route53 and ssl from ACM. It also needs modifiying to support different origins - e.g. api gateway. Ill get around to it...

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
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_s3_bucket.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_behaviours"></a> [behaviours](#input\_behaviours) | n/a | `any` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | n/a | `list(any)` | n/a | yes |
| <a name="input_default_behaviour"></a> [default\_behaviour](#input\_default\_behaviour) | n/a | `any` | n/a | yes |
| <a name="input_geo_restrictions"></a> [geo\_restrictions](#input\_geo\_restrictions) | n/a | `any` | n/a | yes |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Switch to control versioning | `bool` | n/a | yes |
| <a name="input_viewer_certificate"></a> [viewer\_certificate](#input\_viewer\_certificate) | n/a | `map` | <pre>{<br>  "cloudfront_default_certificate": false,<br>  "minimum_protocol_version": "TLSv1.2_2019"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution"></a> [distribution](#output\_distribution) | n/a |
| <a name="output_identity"></a> [identity](#output\_identity) | n/a |
| <a name="output_logging"></a> [logging](#output\_logging) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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

Copyright © 2021 James Woolfenden

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
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-cloudfront-compound&url=https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-cloudfront-compound&url=https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound
[share_reddit]: https://reddit.com/submit/?url=https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound
[share_email]: mailto:?subject=terraform-aws-budget&body=https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound
