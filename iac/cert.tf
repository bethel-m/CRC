# the certificate here is requested from  and managed by aws acm 
# you will be required to manually enter the appropriate records for 
# dns validation in your respective dns provider or use a 
# terraform script to automatically update your dns record


resource "aws_acm_certificate" "bethelmmadu_cert" {
  provider = aws.east
  domain_name = "bethelmmadu.site"
  subject_alternative_names = ["*.bethelmmadu.site"]
  validation_method = "DNS"
  #key_algorithm = "RSA2048"
  tags = {
    "environment" = "production"
  }
  lifecycle {
    create_before_destroy = true
  }
}
