#this is implemented in order to wait for the certificate validation to take effect before proceding
resource "time_sleep" "wait_for_certificate" {
  depends_on = [
    godaddy_domain_record.validation
  ]
  create_duration="15s"
}
data "aws_acm_certificate" "issued" {
  depends_on = [
     time_sleep.wait_for_certificate
  ]
  provider = aws.east
  domain   = "bethelmmadu.site"
  statuses = ["ISSUED"]
}

module "cloudfront" {
  source = "./cloudfront"
  
  domain_name = module.s3.bucket_regional_domain_name
  s3_origin_id = "bethelmmadu_origin"
  enabled = true 
  is_ipv6_enabled = true 
  comment = "this is the cloudfront distribution for bethelmmadu.site s3 bucket"
  default_root_object = "index.html"
  aliases = ["bethelmmadu.site","*.bethelmmadu.site"]
  allowed_methods =  [ "GET", "HEAD"]
  cached_methods =  [ "GET", "HEAD"]
  compress = true 
  viewer_protocol_policy = "redirect-to-https"
  min_ttl=0
  default_ttl=3600
  max_ttl=86400
  restriction_type = "none"
  restricted_locations = []
  #tags = {"environment":"production","oring":"s3"}
  cloudfront_default_certificate = false 
  minimum_protocol_version = "TLSv1.2_2021" 
  ssl_support_method = "sni-only"
  acm_certificate_arn = data.aws_acm_certificate.issued.arn 
  OAC_name = "bethelmmadu.site-OAC"
  OAC_description = "this OAC controls access to the s3 origin"
  OAC_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
  depends_on = [
   time_sleep.wait_for_certificate
  ]
}
 
module "s3" {
  source = "./s3"
  bucket_name = "bethelmmadu.site"
  enable_versioning = "Enabled"
  site_files_path = "../../portfolio_site"
  cloudfront_arn =  [ module.cloudfront.cloudfront_arn]
  depends_on = [
    time_sleep.wait_for_certificate
  ]
}
