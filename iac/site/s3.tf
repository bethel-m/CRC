resource "aws_s3_bucket" "bethelmmadu" {
  bucket = "bethelmmadu.site"
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.bethelmmadu.id 

  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.bethelmmadu.id 

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "encrypt" {
  bucket = aws_s3_bucket.bethelmmadu.id 
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

data "aws_caller_identity" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.bethelmmadu.id 

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "allow_cloudfront_access" {
  bucket = aws_s3_bucket.bethelmmadu.id 
  policy = data.aws_iam_policy_document.allow_cloudfront_access.json
}

data "aws_iam_policy_document" "allow_cloudfront_access" {
  statement {
    sid = "AllowCloudFrontServicePrincipalReadWrite"
    principals{
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = [
        "s3:GetObject",
        "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.bethelmmadu.arn}/*",
    ]
    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"
      values = [ "arn:aws:cloudfront::${local.account_id}:distribution/${aws_cloudfront_distribution.bethelmmadu.id}" ]
    }
  }
}

resource "aws_s3_object" "upload_project" {
  for_each = module.template_files.files
  bucket = aws_s3_bucket.bethelmmadu.id
  key = each.key
  content_type = each.value.content_type
  source = each.value.source_path
  content = each.value.content 
  #etag = each.value.digests.md5
    depends_on = [
    aws_s3_bucket.bethelmmadu
  ]
}

module "template_files" {
  source = "hashicorp/dir/template"
  base_dir = "../../portfolio_site"
}
