terraform {
  backend "s3" {
    bucket = "terraform-backend-22"
    key    = "DevOps_project/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "backend"
  }
}