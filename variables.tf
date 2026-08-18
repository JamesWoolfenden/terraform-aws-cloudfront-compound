# holden:ignore:HLD_TF_027: this module is deliberately a "compound" bundle of CloudFront distribution + response headers policy + S3 logging bucket configuration (see module name/README) -- the variable count reflects that stated scope, not accidental scope creep
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

variable "geo_restrictions" {
  description = "CloudFront geo-restriction configuration; a map with restriction_type (e.g. none, whitelist, blacklist) and locations (list of ISO 3166-1-alpha-2 country codes)."
  type = object({
    restriction_type = string
    locations        = list(string)
  })

  validation {
    condition     = contains(["none", "whitelist", "blacklist"], var.geo_restrictions.restriction_type)
    error_message = "geo_restrictions.restriction_type must be one of \"none\", \"whitelist\", or \"blacklist\"."
  }
}

variable "buckets" {
  type        = list(any)
  description = "List of S3 bucket resources used as CloudFront origins; buckets[0] backs the default cache behavior and buckets[1] backs the first ordered cache behavior. Exactly 2 entries are used -- any beyond that are accepted by the type system but never wired to an origin."

  validation {
    condition     = length(var.buckets) >= 2
    error_message = "buckets must contain at least 2 entries: buckets[0] backs the default cache behavior and buckets[1] backs the first ordered cache behavior."
  }

  validation {
    condition     = length(var.buckets) <= 2
    error_message = "buckets must contain exactly 2 entries: only buckets[0] and buckets[1] are ever wired to a CloudFront origin. A 3rd+ entry would be silently unused."
  }
}

variable "default_behaviour" {
  description = "Default cache behavior configuration for the CloudFront distribution (allowed/cached methods, origin id, forwarded query string/cookies, viewer protocol policy, and TTLs)."
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

  validation {
    condition     = contains(["allow-all", "https-only", "redirect-to-https"], var.default_behaviour.viewer_protocol_policy)
    error_message = "default_behaviour.viewer_protocol_policy must be one of \"allow-all\", \"https-only\", or \"redirect-to-https\"."
  }

  validation {
    condition     = var.default_behaviour.min_ttl <= var.default_behaviour.default_ttl && var.default_behaviour.default_ttl <= var.default_behaviour.max_ttl
    error_message = "default_behaviour TTLs must satisfy min_ttl <= default_ttl <= max_ttl."
  }
}

variable "behaviours" {
  description = "List of ordered cache behavior configurations (path pattern, methods, origin id, forwarded headers/query string/cookies, TTLs, compression, and viewer protocol policy)."
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

  validation {
    condition     = alltrue([for b in var.behaviours : contains(["allow-all", "https-only", "redirect-to-https"], b.viewer_protocol_policy)])
    error_message = "every behaviours[].viewer_protocol_policy must be one of \"allow-all\", \"https-only\", or \"redirect-to-https\"."
  }

  validation {
    condition     = alltrue([for b in var.behaviours : b.min_ttl <= b.default_ttl && b.default_ttl <= b.max_ttl])
    error_message = "every behaviours[] entry's TTLs must satisfy min_ttl <= default_ttl <= max_ttl."
  }
}

variable "price_class" {
  description = "CloudFront price class controlling which edge locations serve the distribution."
  type        = string
  default     = "PriceClass_200"

  validation {
    condition     = contains(["PriceClass_100", "PriceClass_200", "PriceClass_All"], var.price_class)
    error_message = "price_class must be one of \"PriceClass_100\", \"PriceClass_200\", or \"PriceClass_All\"."
  }
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

variable "policy_name" {
  description = "Name of the CloudFront response headers policy."
  type        = string
  default     = "examplea"

  validation {
    condition     = length(var.policy_name) > 0
    error_message = "policy_name must not be empty."
  }
}

variable "viewer_certificate" {
  description = "CloudFront viewer certificate configuration: use the CloudFront default certificate, or set acm_certificate_arn for a custom domain. minimum_protocol_version only takes effect when acm_certificate_arn is set -- CloudFront ignores it for the default certificate."
  type = object({
    cloudfront_default_certificate = bool
    minimum_protocol_version       = string
    acm_certificate_arn            = optional(string)
  })
  default = {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1.2_2019"
  }

  validation {
    condition     = var.viewer_certificate.cloudfront_default_certificate || var.viewer_certificate.acm_certificate_arn != null
    error_message = "viewer_certificate must set acm_certificate_arn when cloudfront_default_certificate is false."
  }
}

# holden:ignore:HLD_TF_012: intentionally untyped (any) to avoid narrowing the input shape for this published module's existing consumers
variable "kms_key" {
  description = "KMS key resource used to encrypt the logging S3 bucket via SSE-KMS."
  sensitive   = true
}
