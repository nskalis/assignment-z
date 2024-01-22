module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  proj_name   = var.proj_name
  labels      = local.common_tags

  vpc_network               = var.vpc_network
  vpc_public_networks_list  = var.vpc_public_networks_list
  vpc_private_networks_list = var.vpc_private_networks_list
}

module "eks" {
  source      = "./modules/eks"
  environment = var.environment
  proj_name   = var.proj_name
  labels      = local.common_tags

  vpc_id                    = module.vpc.vpc_id
  vpc_private_networks_list = module.vpc.vpc_private_networks_list
  kube_version              = var.kube_version
  kube_nodes_types          = var.kube_nodes_types
  kube_nodes_count          = var.kube_nodes_count

  ec2_key_pair_name      = module.keypair.ec2_key_pair_name
  vpc_security_group_ids = [module.jumphost.ssh_from_jumphost_sg]
}

module "keypair" {
  source      = "./modules/keypair"
  environment = var.environment
  labels      = local.common_tags

  ec2_key_pair_name        = var.ec2_key_pair_name
  ec2_private_key_filename = var.ec2_private_key_filename
}

module "jumphost" {
  source      = "./modules/jumphost"
  environment = var.environment
  labels      = local.common_tags

  vpc_id                   = module.vpc.vpc_id
  jumphost_subnet_id       = module.vpc.vpc_public_networks_list[0]
  ec2_key_pair_name        = module.keypair.ec2_key_pair_name
  ec2_private_key_filename = var.ec2_private_key_filename
}
