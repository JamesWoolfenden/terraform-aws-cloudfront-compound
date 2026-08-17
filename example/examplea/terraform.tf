# holden:ignore:HLD_TF_004: example has no remote backend by convention, same as sibling modules
terraform {
  required_providers {
    # holden:ignore:HLD_TF_005: this module family doesn't commit .terraform.lock.hcl for example fixtures (same as sibling modules, e.g. terraform-aws-alb)
    aws = {
      source  = "hashicorp/aws"
      version = "6.43.0"
    }
  }
  required_version = ">= 1.5.0"
}
