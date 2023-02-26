output "validation_options" {
  value = aws_acm_certificate.bethelmmadu_cert.domain_validation_options
  description = "this is the dns validation options(records) to be put in your dns provider or records"
}
