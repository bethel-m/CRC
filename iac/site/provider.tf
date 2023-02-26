
terraform {
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

# this is required for the aws acm(certificate manager) since its required
# to be created in us-east-1
provider "aws" {
  region = "us-east-1"
  alias = "east"
}