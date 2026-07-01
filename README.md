# AWS EKS & VPC Infrastructure with Terraform

[![Terraform CI/CD](https://github.com/Yukihara64/terraform-aws-enterprise-eks/actions/workflows/terraform-ci-cd.yml/badge.svg)](https://github.com/Yukihara64/terraform-aws-enterprise-eks/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Overview
This project automates the deployment of a Kubernetes (Amazon EKS) cluster and networking infrastructure on AWS using Terraform and OpenTofu. It was built to demonstrate practical Infrastructure as Code (IaC) principles, cloud cost optimization, and automated security linting.

## Key Features

| Feature | Description |
| :--- | :--- |
| **Modular VPC & EKS Setup** | Custom VPC architecture with public and private subnets, NAT gateways, and an EKS cluster managed via modular Terraform configurations. |
| **Cost Optimization** | Configured managed node groups utilizing AWS Spot instances to reduce compute costs while maintaining cluster availability. |
| **Least-Privilege IAM (IRSA)** | Implements IAM Roles for Service Accounts (IRSA) so Kubernetes Pods can securely access AWS resources without hardcoded credentials. |
| **Automated Security Scanning** | Includes a GitHub Actions workflow that runs `terraform fmt`, validates syntax, and scans for infrastructure vulnerabilities using Checkov and tfsec. |

## Repository Structure
```text
├── main.tf           # Core provider configurations and remote backend setup
├── vpc.tf            # Virtual Private Cloud networking, route tables, and subnets
├── eks.tf            # EKS cluster control plane and managed node group definitions
├── iam.tf            # IAM roles, policies, and OIDC provider integration
├── variables.tf      # Input variable definitions
└── outputs.tf        # Cluster endpoints and resource outputs
```

## Getting Started
To initialize and validate this infrastructure locally:

```bash
# Initialize Terraform provider plugins
terraform init

# Validate configuration syntax
terraform validate

# Preview the deployment plan
terraform plan

# Apply changes (requires valid AWS credentials)
terraform apply
```
