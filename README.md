# terraform-aws-cloudfront-compound

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-cloudfront-compound.svg)](https://github.com/JamesWoolfenden/terraform-aws-cloudfront-compound/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

Terraform module to provision multiple Origins and multiple routes via behaviors.

The example examplea creates 2 s3 origins and multiple behaviors to different paths, the root points to one bucket and index.html and theres are 2 paths path1 which has one file cat.jpg and path2 which has dog.jpg.

## ToDO

This module needs merging with the general cloudfront-s3 one I have, adding in route53 and ssl from ACM. It also needs modifiying to support different origins - e.g. api gateway. Ill get around to it...

## Usage

Create a file call **module.cloudfront.tf**:

```
module "cloudfront" {

}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | 3.19.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 3.19.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| behaviours | n/a | `any` | n/a | yes |
| bucket\_name | n/a | `string` | n/a | yes |
| buckets | n/a | `list` | n/a | yes |
| common\_tags | n/a | `map` | n/a | yes |
| default\_behaviour | n/a | `any` | n/a | yes |
| geo\_restrictions | n/a | `any` | n/a | yes |
| versioning | Switch to control versioning | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| distribution | n/a |
| identity | n/a |

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

Copyright © 2020 James Woolfenden

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
