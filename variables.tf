variable "aws_region" {
  description = "AWS region where cloud infrastructure will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name (e.g., prod, staging, dev)"
  type        = string
  default     = "prod"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "cluster_name" {
  description = "Name of the Amazon EKS Kubernetes cluster"
  type        = string
  default     = "enterprise-prod-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes minor version to deploy for EKS control plane"
  type        = string
  default     = "1.29"
}

variable "vpc_cidr" {
  description = "CIDR block for the High-Availability VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_spot_instances" {
  description = "Enable Spot Instance node group to optimize cloud costs by up to 70%"
  type        = bool
  default     = true
}

variable "node_group_configs" {
  description = "Configuration map for EKS managed node groups"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size      = number
  }))
  default = {
    on_demand_system = {
      instance_types = ["t3.medium", "t3a.medium"]
      capacity_type  = "ON_DEMAND"
      min_size       = 2
      max_size       = 4
      desired_size   = 2
      disk_size      = 50
    }
    spot_workload = {
      instance_types = ["m5.large", "m5a.large", "m6i.large"]
      capacity_type  = "SPOT"
      min_size       = 3
      max_size       = 10
      desired_size   = 3
      disk_size      = 100
    }
  }
}

variable "enable_network_policies" {
  description = "Enable Calico/Cilium Kubernetes Network Policies for pod isolation"
  type        = bool
  default     = true
}
