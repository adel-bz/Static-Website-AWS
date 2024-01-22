# Providers Setting

## AWS
provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

#############################################################
#############################################################

## Cloudflayr
provider "cloudflare" {
  api_token = var.cloudflayr_token
}

#############################################################
#############################################################

# Locals Variables
locals {
  perfix = "${var.perfix}-${terraform.workspace}-${var.project}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
  }
}