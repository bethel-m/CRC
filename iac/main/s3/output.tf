output "bucket_regional_domain_name" {
  description = "this is the regional domain name of the s3 bucket"
  value = aws_s3_bucket.bethelmmadu.bucket_regional_domain_name
}
