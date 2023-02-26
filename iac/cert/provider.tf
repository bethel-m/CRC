terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.16"
    }

    godaddy = {
      source = "n3integration/godaddy"
      version = "1.9.1"
    }
}
}

provider "godaddy" {
  key = var.GODADDY_API_KEY
  secret = var.GODADDY_API_SECRET
}
provider "aws" {
  region = "us-east-1"
}