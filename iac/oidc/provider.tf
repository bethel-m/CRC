terraform {
  backend "s3" {
    bucket =  "bethelmmadu.site-backend-state-storage"
    key = "GITHUB-ACTIONS-OIDC/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "bethelmmadu.site-bucket-locks"
    encrypt = true   
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}