output "cloudfront_arn" {
  description = "arn of the created cloudfront"
  value = aws_cloudfront_distribution.bethelmmadu.arn 
}
output "cloudfront_domain_name" {
  description = "domain name of the created cloudfront"
  value = aws_cloudfront_distribution.bethelmmadu.domain_name
}