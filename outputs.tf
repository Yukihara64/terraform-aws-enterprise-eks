output "cluster_name" {
  description = "Amazon EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS Kubernetes API server"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS control plane"
  value       = module.eks.cluster_security_group_id
}

output "oidc_provider_arn" {
  description = "IAM OIDC Provider ARN for configuring IRSA (IAM Roles for Service Accounts)"
  value       = module.eks.oidc_provider_arn
}

output "vpc_id" {
  description = "ID of the provisioned High-Availability VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private application subnets across 3 Availability Zones"
  value       = module.vpc.private_subnets
}

output "configure_kubectl_command" {
  description = "Command to automatically configure local kubeconfig for terminal access"
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks.cluster_name}"
}
