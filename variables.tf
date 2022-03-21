variable "versioning" {
  type        = bool
  description = "Switch to control versioning"
}

variable "bucket_name" {
  type = string
}


variable "geo_restrictions" {
}

variable "buckets" {
  type = list(any)
}

variable "default_behaviour" {}

variable "behaviours" {}



variable "content_security_policy" {
  type = map(any)
  default = {
    content_security_policy = "default-src 'none'; img-src 'self'; script-src 'self'; style-src 'self'; object-src 'none'; frame-ancestors 'none'"
    override                = true
  }
}

variable "content_type_options" {
  type = map(any)
  default = {
    override = true
  }
}

variable "frame_options" {
  type = map(any)
  default = {
    frame_option = "DENY"
    override     = true
  }
}

variable "referrer_policy" {
  type = map(any)
  default = { referrer_policy = "same-origin"
    override = true
  }
}

variable "strict_transport_security" {
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
}

variable "xss_protection" {
  type = map(any)
  default = {
    mode_block = true
    override   = true
    protection = true
  }
}

variable "policy_name" {
  default = "examplea"
}


variable "viewer_certificate" {
  default = {
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2019"
  }
}

variable "kms_key" {

}
