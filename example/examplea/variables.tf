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
# holden:ignore:HLD_TF_021: pure pass-through to module.cloudfront's geo_restrictions input, which already validates restriction_type at the call boundary
variable "geo_restrictions" {
  description = "CloudFront geo-restriction configuration passed through to the cloudfront module (restriction_type and locations)."
  type = object({
    restriction_type = string
    locations        = list(string)
  })
}
# holden:ignore:HLD_TF_021: pure pass-through to module.cloudfront's default_behaviour input, which already validates viewer_protocol_policy and TTL ordering at the call boundary
variable "default_behaviour" {
  description = "Default cache behavior configuration passed through to the cloudfront module."
  type = object({
    origin_id              = string
    allowed_methods        = list(string)
    cached_methods         = list(string)
    query_string           = bool
    forward                = string
    viewer_protocol_policy = string
    min_ttl                = number
    default_ttl            = number
    max_ttl                = number
    compress               = optional(bool, false)
  })
}
# holden:ignore:HLD_TF_021: pure pass-through to module.cloudfront's behaviours input, which already validates viewer_protocol_policy and TTL ordering at the call boundary
variable "behaviours" {
  description = "List of ordered cache behavior configurations passed through to the cloudfront module."
  type = list(object({
    path_pattern           = string
    allowed_methods        = list(string)
    cached_methods         = list(string)
    origin_id              = string
    headers                = list(string)
    query_string           = bool
    forward                = string
    min_ttl                = number
    default_ttl            = number
    max_ttl                = number
    compress               = bool
    viewer_protocol_policy = string
  }))
}
