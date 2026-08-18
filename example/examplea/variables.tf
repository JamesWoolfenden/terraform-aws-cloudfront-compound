variable "versioning" {
  type        = bool
  description = "Switch to control versioning"
}
variable "bucket_name" {
  type        = string
  description = "Base name used to derive this example's S3 bucket names."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "bucket_name must be 3-63 lowercase alphanumeric/hyphen characters, starting and ending with a letter or digit, per S3 bucket naming rules."
  }
}
# holden:ignore:HLD_TF_012: intentionally untyped (any); passed straight through to the cloudfront module's own untyped variable of the same name
variable "geo_restrictions" {
  description = "CloudFront geo-restriction configuration passed through to the cloudfront module (restriction_type and locations)."
}
# holden:ignore:HLD_TF_012: intentionally untyped (any); passed straight through to the cloudfront module's own untyped variable of the same name
variable "default_behaviour" {
  description = "Default cache behavior configuration passed through to the cloudfront module."
}
# holden:ignore:HLD_TF_012: intentionally untyped (any); passed straight through to the cloudfront module's own untyped variable of the same name
variable "behaviours" {
  description = "List of ordered cache behavior configurations passed through to the cloudfront module."
}
