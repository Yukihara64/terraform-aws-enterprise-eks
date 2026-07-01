terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.26"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  # Production backend configuration (commented out for local testing/demo)
  # backend "s3" {
  #   bucket         = "enterprise-terraform-state-prod"
  #   key            = "eks/production/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock-prod"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "Enterprise-Cloud-Platform"
      ManagedBy   = "Terraform"
      Repository  = "terraform-aws-enterprise-eks"
      Owner       = "DevOps-SRE-Team"
    }
  }
}
