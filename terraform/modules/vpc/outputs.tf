output "vpc_id" {
  description = "vpc id"
  value       = module.vpc.vpc_id
}

output "vpc_network" {
  description = "vpc address range"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_private_networks_list" {
  description = "list of vpc private networks"
  value       = module.vpc.private_subnets
}

output "vpc_public_networks_list" {
  description = "list of vpc public networks"
  value       = module.vpc.public_subnets
}

output "vpc_nat_gateway_eip_list" {
  description = "list of nat gateway elastic ip addresses"
  value       = module.vpc.nat_public_ips
}

output "vpc_availability_zones" {
  description = "list of vpc availabilty zones"
  value       = module.vpc.azs
}
