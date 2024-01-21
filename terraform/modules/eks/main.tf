module "eks" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=2cb1fac"

  cluster_name                   = "${var.environment}-${var.proj_name}-eks"
  cluster_version                = var.kube_version
  cluster_enabled_log_types      = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_endpoint_public_access = true
  create_kms_key                 = false
  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = module.kms.key_arn
  }
  vpc_id     = var.vpc_id
  subnet_ids = var.vpc_private_networks_list

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = var.kube_nodes_types
    vpc_security_group_ids = [aws_security_group.additional.id]
    iam_role_additional_policies = {
      additional = aws_iam_policy.additional.arn
    }
    key_name = var.ec2_key_pair_name
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

  cluster_security_group_additional_rules = {
    ingress_nodes_ephemeral_ports_tcp = {
      description                = "nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
    ingress_source_security_group_id = {
      description              = "ingress from another computed security group"
      protocol                 = "tcp"
      from_port                = 22
      to_port                  = 22
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional.id
    }
  }
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    ingress_source_security_group_id = {
      description              = "ingress from another computed security group"
      protocol                 = "tcp"
      from_port                = 22
      to_port                  = 22
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional.id
    }
  }

  tags = var.labels
}

resource "aws_security_group" "additional" {
  name        = "from-private-networks"
  description = "from private networks (ssh)"
  vpc_id      = var.vpc_id

  ingress {
    description = "from private networks (ssh)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }

  tags = var.labels
}
