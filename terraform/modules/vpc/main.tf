data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=7666869"

  name = "${var.environment}-${var.proj_name}-vpc"
  cidr = var.vpc_network
  azs  = slice(data.aws_availability_zones.available.names, 0, length(var.vpc_public_networks_list))

  public_subnets       = var.vpc_public_networks_list
  private_subnets      = var.vpc_private_networks_list
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb"                                        = 1
    "kubernetes.io/cluster/${var.environment}-${var.proj_name}-eks" = "shared"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"                               = 1
    "kubernetes.io/cluster/${var.environment}-${var.proj_name}-eks" = "shared"
  }
  
  tags = var.labels
}
