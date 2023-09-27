terraform {
  backend "s3" {
    bucket         = "te1st"
    key            = "Terraform-Ansible/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "backend"
  }

}

