module "eks" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=2cb1fac"

  cluster_name                         = "${var.environment}-${var.proj_name}-eks"
  cluster_version                      = var.kube_version
  cluster_enabled_log_types            = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] # todo: 
  create_kms_key                       = false
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms.key_arn
  }
  vpc_id     = var.vpc_id
  subnet_ids = var.vpc_private_networks_list

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = var.kube_nodes_types
    iam_role_additional_policies = {
      additional = aws_iam_policy.additional.arn
    }
    key_name               = var.ec2_key_pair_name
    vpc_security_group_ids = var.vpc_security_group_ids
  }
  eks_managed_node_groups = {
    workers = {
      instance_types = var.kube_nodes_types
      min_size       = 1
      desired_size   = 1
      max_size       = var.kube_nodes_count
      update_config = {
        max_unavailable = 1
      }

      tags = var.labels
    }
  }

  tags = var.labels
}
