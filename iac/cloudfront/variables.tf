variable "domain_name"{
  description = "this is the s3 regional domain name to connect cloudfront to"
  type = string 
}

variable "s3_origin_id" {
  description = "unique identification for the s3 origin, default is bethelmmadu_origin"
  type = string 
  default = "bethelmmadu_origin"
}

variable "enabled" {
  description = "should the cloudfront be enabled or not , default is true"
  type = bool
  default = true 
}

variable "is_ipv6_enabled" {
  description = "boolean represening if ipv6 should be enabled or not "
  type = bool 
  default = true 
}

variable "comment" {
  description = "this is the description note for the created cloudfront,default is an empty string"
  type = string 
  default = ""
}
variable "default_root_object" {
  description = " value of the default root object in the s3 origin,default is index.html"
  type = string 
  default = "index.html"
}

variable "aliases" {
  description = "this represent list of domain names to associate with the cloudfront,default is an empty list"
  type = list
  default = []
}

variable "allowed_methods" {
  description = "list of allowed methods for accessing the cloudfront, default is [GET,HEAD]"
  type = list 
  default = [ "GET", "HEAD"]
}

variable "cached_methods" {
  description = "list of allowed methods that allow caching,default is [GET,HEAD]"
  type = list 
  default = ["GET", "HEAD"]
}

variable "compress" {
  description = "boolean representing if to allow compression or not,default is true"
  type = bool 
  default = true 
}

variable "viewer_protocol_policy" {
  description = "this is the viewer protocol on how users are allowed to access cloudfront, default is 'redirect-to-https'"
  type = string 
  default = "redirect-to-https"
}

variable "min_ttl" {
  description = "this is the minimum time to live of for the cache of the cloudfront,default is 0"
  type = number
  default =0 
}
variable "default_ttl" {
  description = "this is the default time to live of for the cache of the cloudfront,default is 3600"
  type = number
  default = 3600
}
variable "max_ttl" {
  description = "this is the maximum time to live of for the cache of the cloudfront,default is 86400"
  type = number
  default = 86400
}
variable "aws_cloudfront_cache_policy" {
  description = "this is the cache policy id to use for default cache behavior,default is am empty string which will be replaced by the 'Managed-CachingOptimized' policy"
  type = string 
  default = ""
}

variable "restriction_type" {
  description = "geo_restriction type to place on cloudfront,default is none"
  type = string 
  default = "none"
}

variable "restricted_locations"{
  description = "list of locations to be restricted from accessing the cloudfront, before setting this make sure restriction type is not set to none, default is an empty list"
  type = list 
  default = []
}

variable "tags" {
  description = "this is a map of tags to add to the cloudfront"
  type = map 
  default = {"environment":"production"}
}

variable "cloudfront_default_certificate" {
  description = "this is an option to allow the default cloudfront certificate,if set to false please provide a certificate, default true"
  type = bool 
  default = false  
}

variable "minimum_protocol_version" {
  description = "this is the minimum version of ssl/tls protocol to use,this is if you set cloudfront's default certificate to false,default is 'TLSv1.2_2021'"
  type = string 
  default = "TLSv1.2_2021" 
}

variable "ssl_support_method" {
  description = "this represents the ssl-support method to be specified,this is if the cloudfront's default certificate is set to false,default is 'sni-only'"
  type = string 
  default = "sni-only"
}
variable "acm_certificate_arn" {
  description = "this is the arn of acm certificate to use, this is if the cloudfront's default certificate is set to false"
  type = string
}

variable "OAC_name" {
  description = "this is the name of the OAC for the s3 origin,default 'bethelmmadu.site-OAC'"
  type = string 
  default = "bethelmmadu.site-OAC"
}
variable "OAC_description" {
  description = "this is the description for the oac for the s3 origin, default 'control access to s3'"
  type = string
  default = "control access to s3 "
}
variable "OAC_type" {
  description = "this is the OAC type ,default is s3"
  type = string 
  default = "s3"
}
variable "signing_behavior" {
  description = "this is the signing behaviour to be associated with the created OAC,default is 'always'"
  type = string 
  default = "always"
}

variable "signing_protocol"{
  description = "this is the signing protocol to be associated with the created OAC, default is 'sigv4'"
  type =string 
  default = "sigv4"
}
