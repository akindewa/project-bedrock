// main configuration
// Root Terraform config (providers, backend, etc.)

// main.tf
// Root Terraform configuration
// - Sets Terraform + provider versions
// - Connects to AWS

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # For now we’ll use local state (cheaper, simple)
  # Later, we can configure remote backend (e.g., S3 + DynamoDB) if needed.
  backend "local" {
    path = "terraform.tfstate"
  }
}

# Configure AWS provider
provider "aws" {
  region = "us-east-1" # Change if you want Ireland → eu-west-1
}

/*
terraform {} → sets the Terraform + provider versions.

provider "aws" → connects to AWS (uses the CLI credentials you already configured with aws configure).

backend "local" → Terraform state file will be saved locally (no AWS costs).
*/