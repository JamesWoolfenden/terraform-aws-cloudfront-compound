common_tags = {
  Name = "My bucket"
}

bucket_name = "anotherprivatemybucket"
geo_restrictions = {
  restriction_type = "whitelist"
  locations        = ["US", "CA", "GB", "DE"]
}
versioning = true

default_behaviour = {
  origin_id              = "myS3Origin"
  allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  cached_methods         = ["GET", "HEAD"]
  query_string           = false
  forward                = "none"
  viewer_protocol_policy = "redirect-to-https"
  min_ttl                = 0
  default_ttl            = 3600
  max_ttl                = 86400
}

behaviours = [
  {
    origin_id              = "routed"
    path_pattern           = "/path2/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    query_string           = false
    headers                = ["Origin"]
    forward                = "none"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  },
  {
    path_pattern           = "/path1/*"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    origin_id              = "routed"
    query_string           = false
    headers                = []
    forward                = "none"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }
]
