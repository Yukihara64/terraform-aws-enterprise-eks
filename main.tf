locals {
  name   = "${var.cluster_name}-${var.environment}"
  region = var.aws_region

  tags = {
    Cluster     = local.name
    Environment = var.environment
    Terraform   = "true"
  }
}

################################################################################
# 🌐 High-Availability Multi-AZ VPC Architecture
################################################################################
module "vpc" {
  source = "./modules/vpc"

  name     = "${local.name}-vpc"
  cidr     = var.vpc_cidr
  azs      = ["${local.region}a", "${local.region}b", "${local.region}c"]
  
  # Subnet CIDR allocation across 3 AZs
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
  database_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = var.environment == "dev" ? true : false
  enable_dns_hostnames = true

  tags = local.tags
}

################################################################################
# 🔐 AWS KMS Envelope Encryption Keys
################################################################################
module "security" {
  source = "./modules/security"

  environment = var.environment
  tags        = local.tags
}

################################################################################
# ☸️ Amazon EKS Cluster & IRSA Configuration
################################################################################
module "eks" {
  source = "./modules/eks"

  cluster_name    = local.name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # KMS Envelope Encryption for Kubernetes Secrets
  cluster_encryption_config = {
    provider_key_arn = module.security.kms_key_arn
    resources        = ["secrets"]
  }

  # Enable OIDC Provider for Least-Privilege IRSA Pod Permissions
  enable_irsa = true

  node_groups = var.node_group_configs

  tags = local.tags
}
