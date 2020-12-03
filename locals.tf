locals {
  origins = [{
    origin_read_timeout    = null
    domain_name            = var.buckets[0].bucket_regional_domain_name
    custom_header          = null
    origin_id              = var.default_behaviour.origin_id
    origin_path            = ""
    origin_access_identity = aws_cloudfront_origin_access_identity.site.cloudfront_access_identity_path
    },
    {
      origin_read_timeout    = null
      domain_name            = var.buckets[1].bucket_regional_domain_name
      custom_header          = null
      origin_id              = var.behaviours[0].origin_id
      origin_path            = ""
      origin_access_identity = aws_cloudfront_origin_access_identity.site.cloudfront_access_identity_path
    }
  ]
}
