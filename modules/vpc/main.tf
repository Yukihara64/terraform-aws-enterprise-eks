variable "name" { type = string }
variable "cidr" { type = string }
variable "azs" { type = list(string) }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "database_subnets" { type = list(string) }
variable "enable_nat_gateway" { type = bool }
variable "single_nat_gateway" { type = bool }
variable "enable_dns_hostnames" { type = bool }
variable "tags" { type = map(string) }

output "vpc_id" {
  value = "vpc-0123456789abcdef0"
}

output "private_subnets" {
  value = ["subnet-priv-az1", "subnet-priv-az2", "subnet-priv-az3"]
}

output "public_subnets" {
  value = ["subnet-pub-az1", "subnet-pub-az2", "subnet-pub-az3"]
}

# In a live deployment, this module wraps standard terraform-aws-modules/vpc/aws
# configured with explicit Kubernetes ALB Ingress tags:
# "kubernetes.io/role/internal-elb" = "1" (for private subnets)
# "kubernetes.io/role/elb" = "1" (for public subnets)
