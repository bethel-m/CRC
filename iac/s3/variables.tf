variable "bucket_name" {
  description = "this is the name of the bucket to be created"
  type = string 
}

variable "enable_versioning"{
  description = "this is a string specifying whether to enable versioning or not"
  type = string
  default = "Enabled"
}

variable "cloudfront_arn"{
  description = "this is the arn of the cloudfront distribution to be given access to the s3 bucket"
  type = list(string)
}

variable "site_files_path" {
  description = "this is the path to the site files to be uploaded to s3"
  type = string 
  default = "../portfolio_site"
}