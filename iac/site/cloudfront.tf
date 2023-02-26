resource "aws_cloudfront_distribution" "bethelmmadu" {
  origin {
    domain_name = aws_s3_bucket.bethelmmadu.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.access_control.id 
    origin_id = local.s3_origin_id
  }
  enabled = true 
  is_ipv6_enabled = true 
  comment = "this cloudfront serves as a cdn to the s3 bucket hosting the bethelmmadu.site files"
  default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false 
  #   bucket = "logs_bucket"
  #   prefix = "logs"
  # }
  aliases = [ "bethelmmadu.site","*.bethelmmadu.site" ]

  default_cache_behavior {
    allowed_methods  = [ "GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    compress = true 
    cache_policy_id = data.aws_cloudfront_cache_policy.cache_policy.id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
    restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method = "sni-only"
    acm_certificate_arn = data.aws_acm_certificate.issued.arn
  }
}
data "aws_cloudfront_cache_policy" "cache_policy" {
  name = "Managed-CachingOptimized"
}
locals {
  s3_origin_id = "bethelmmadu_origin"
}
resource "aws_cloudfront_origin_access_control" "access_control" {
  name = "bethelmmadu.site-OAC"
  description = "control access to s3"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
  
}

data "aws_acm_certificate" "issued" {
  provider = aws.east
  domain   = "bethelmmadu.site"
  statuses = ["ISSUED"]
}