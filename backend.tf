# Terraform Backend Config
terraform {
  backend "s3" {
    bucket         = "terraform-bucket-backend-example"
    key            = "terraform-bucket-backend.example"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-backend-lock-example"
  }

}
