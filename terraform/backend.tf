  # TF STATE BACKEND
  terraform {
    backend "s3" {
  bucket         = "medusa-cicd-tfstate-bucket"
      key            = "prod/terraform.tfstate"
      region         = "us-east-1"
    }
  }
