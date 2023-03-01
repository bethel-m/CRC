resource "aws_cloudfront_distribution" "bethelmmadu" {
  origin {
    domain_name = var.domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.access_control.id 
    origin_id = var.s3_origin_id
  }
  enabled = var.enabled
  is_ipv6_enabled = var.is_ipv6_enabled
  comment = var.comment
  default_root_object = var.default_root_object

  # logging_config {
  #   include_cookies = false 
  #   bucket = "logs_bucket"
  #   prefix = "logs"
  # }
  aliases = var.aliases

  default_cache_behavior {
    allowed_methods  =  var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.s3_origin_id
    compress = var.compress

    #check if  cache policy was provided,if it is not use the provided one 
    cache_policy_id = var.aws_cloudfront_cache_policy != "" ? var.aws_cloudfront_cache_policy : aws_cloudfront_cache_policy.cache_policy.id
    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }
    restrictions {
    geo_restriction {
      restriction_type = var.restriction_type 
      locations        = var.restricted_locations
    }
  }

  # tags = {
  #   for_each = var.tags 
  #   key = each.key 
  #   value = each.value
  # }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    minimum_protocol_version = var.minimum_protocol_version
    ssl_support_method = var.ssl_support_method
    acm_certificate_arn =var.acm_certificate_arn
  }
}
# data "aws_cloudfront_cache_policy" "cache_policy" {
#   name = "Managed-CachingOptimized"
# }

resource "aws_cloudfront_origin_access_control" "access_control" {
  name = var.OAC_name
  description = var.OAC_description
  origin_access_control_origin_type = var.OAC_type
  signing_behavior = var.signing_behavior
  signing_protocol = var.signing_protocol
}

resource "aws_cloudfront_cache_policy" "cache_policy" {
  name = "mysite-cache-policy"
  comment = "this policy governs how resources are cached on the cloudfront edge locations"
  default_ttl = 43200
  max_ttl     = 86400
  min_ttl     = 50
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
    enable_accept_encoding_gzip = true
  }
}
