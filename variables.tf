variable "versioning" {
  type        = bool
  description = "Switch to control versioning"
}
variable "bucket_name" {
  type        = string
  description = "Base name used to derive the CloudFront distribution's associated S3 bucket names (e.g. the logging bucket)."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,53}[a-z0-9]$", var.bucket_name))
    error_message = "bucket_name must be 3-55 lowercase alphanumeric/hyphen characters, starting and ending with a letter or digit, to leave room for the \"-logging\" suffix within the 63-character S3 bucket name limit."
  }
}
# holden:ignore:HLD_TF_012: intentionally untyped (any) to avoid narrowing the input shape for this published module's existing consumers
variable "geo_restrictions" {
  description = "CloudFront geo-restriction configuration; a map with restriction_type (e.g. none, whitelist, blacklist) and locations (list of ISO 3166-1-alpha-2 country codes)."
}
variable "buckets" {
  type        = list(any)
  description = "List of S3 bucket resources used as CloudFront origins; buckets[0] backs the default cache behavior and buckets[1] backs the first ordered cache behavior."

  validation {
    condition     = length(var.buckets) >= 2
    error_message = "buckets must contain at least 2 entries: buckets[0] backs the default cache behavior and buckets[1] backs the first ordered cache behavior."
  }
}
# holden:ignore:HLD_TF_012: intentionally untyped (any) to avoid narrowing the input shape for this published module's existing consumers
variable "default_behaviour" {
  description = "Default cache behavior configuration for the CloudFront distribution (allowed/cached methods, origin id, forwarded query string/cookies, viewer protocol policy, and TTLs)."
}
# holden:ignore:HLD_TF_012: intentionally untyped (any) to avoid narrowing the input shape for this published module's existing consumers
variable "behaviours" {
  description = "List of ordered cache behavior configurations (path pattern, methods, origin id, forwarded headers/query string/cookies, TTLs, compression, and viewer protocol policy)."
}
variable "content_security_policy" {
  type        = map(any)
  description = "Content-Security-Policy response header configuration applied via the CloudFront response headers policy."
  default = {
    content_security_policy = "default-src 'none'; img-src 'self'; script-src 'self'; style-src 'self'; object-src 'none'; frame-ancestors 'none'"
    override                = true
  }

  validation {
    condition     = alltrue([contains(keys(var.content_security_policy), "content_security_policy"), contains(keys(var.content_security_policy), "override")])
    error_message = "content_security_policy must set both the \"content_security_policy\" and \"override\" keys."
  }
}
variable "content_type_options" {
  type        = map(any)
  description = "X-Content-Type-Options response header configuration applied via the CloudFront response headers policy."
  default = {
    override = true
  }

  validation {
    condition     = contains(keys(var.content_type_options), "override")
    error_message = "content_type_options must set the \"override\" key."
  }
}
variable "frame_options" {
  type        = map(any)
  description = "X-Frame-Options response header configuration applied via the CloudFront response headers policy."
  default = {
    frame_option = "DENY"
    override     = true
  }

  validation {
    condition     = alltrue([contains(keys(var.frame_options), "frame_option"), contains(keys(var.frame_options), "override")])
    error_message = "frame_options must set both the \"frame_option\" and \"override\" keys."
  }
}

variable "referrer_policy" {
  type        = map(any)
  description = "Referrer-Policy response header configuration applied via the CloudFront response headers policy."
  default = { referrer_policy = "same-origin"
    override = true
  }

  validation {
    condition     = alltrue([contains(keys(var.referrer_policy), "referrer_policy"), contains(keys(var.referrer_policy), "override")])
    error_message = "referrer_policy must set both the \"referrer_policy\" and \"override\" keys."
  }
}

variable "strict_transport_security" {
  description = "Strict-Transport-Security (HSTS) response header configuration applied via the CloudFront response headers policy."
  type = object({
    access_control_max_age_sec = number
    include_subdomains         = bool
    override                   = bool
    preload                    = bool
  })
  default = {
    access_control_max_age_sec = 31536000
    include_subdomains         = true
    override                   = true
    preload                    = true
  }

  validation {
    condition     = var.strict_transport_security.access_control_max_age_sec > 0
    error_message = "strict_transport_security.access_control_max_age_sec must be a positive number of seconds."
  }
}
variable "xss_protection" {
  type        = map(any)
  description = "X-XSS-Protection response header configuration applied via the CloudFront response headers policy."
  default = {
    mode_block = true
    override   = true
    protection = true
  }

  validation {
    condition     = alltrue([contains(keys(var.xss_protection), "mode_block"), contains(keys(var.xss_protection), "override"), contains(keys(var.xss_protection), "protection")])
    error_message = "xss_protection must set the \"mode_block\", \"override\", and \"protection\" keys."
  }
}

# holden:ignore:HLD_TF_012: intentionally untyped (any) to avoid narrowing the input shape for this published module's existing consumers
variable "policy_name" {
  description = "Name of the CloudFront response headers policy."
  default     = "examplea"
}

# holden:ignore:HLD_TF_012: intentionally untyped (any) to avoid narrowing the input shape for this published module's existing consumers
variable "viewer_certificate" {
  description = "CloudFront viewer certificate configuration (whether to use the CloudFront default certificate and the minimum TLS protocol version)."
  default = {
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2019"
  }
}

# holden:ignore:HLD_TF_012: intentionally untyped (any) to avoid narrowing the input shape for this published module's existing consumers
variable "kms_key" {
  description = "KMS key resource used to encrypt the logging S3 bucket via SSE-KMS."
  sensitive   = true
}
