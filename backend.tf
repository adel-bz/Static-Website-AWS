# Terraform Backend Config
terraform {
  backend "s3" {
    bucket         = "terraform-front-tfstate"
    key            = "terraform-front.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-front-lock"
  }

}
