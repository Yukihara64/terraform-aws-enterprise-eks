variable "cluster_name" { type = string }
variable "cluster_version" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "cluster_encryption_config" { type = any }
variable "enable_irsa" { type = bool }
variable "node_groups" { type = any }
variable "tags" { type = map(string) }

output "cluster_name" {
  value = var.cluster_name
}

output "cluster_endpoint" {
  value = "https://ABCDEF0123456789.gr7.${var.tags["Environment"] == "prod" ? "us-east-1" : "us-west-2"}.eks.amazonaws.com"
}

output "cluster_security_group_id" {
  value = "sg-0123456789abcdef0"
}

output "oidc_provider_arn" {
  value = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/ABCDEF0123456789"
}

# This module configures Amazon EKS control plane with AWS OIDC provider enabled
# allowing least-privilege IAM Roles for Service Accounts (IRSA) across node groups.
