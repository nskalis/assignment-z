output "cluster_arn" {
  description = "cluster arn"
  value       = module.eks.cluster_arn
}

output "cluster_certificate_authority_data" {
  description = "certificate data required by kubernetes clients (base64 encoded)"
  value       = module.eks.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "endpoint for kube-apiserver"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "eks cluster name"
  value       = module.eks.cluster_name
}

output "kms_key_arn" {
  description = "key arn"
  value       = module.eks.kms_key_arn
}

output "kms_key_id" {
  description = "kms key id"
  value       = module.eks.kms_key_id
}

output "kms_key_policy" {
  description = "kms key resource policy"
  value       = module.eks.kms_key_policy
}

output "cluster_security_group_arn" {
  description = "cluster security group arn"
  value       = module.eks.cluster_security_group_arn
}

output "cluster_security_group_id" {
  description = "cluster security group id"
  value       = module.eks.cluster_security_group_id
}

output "node_security_group_arn" {
  description = "node shared security group arn"
  value       = module.eks.node_security_group_arn
}

output "node_security_group_id" {
  description = "node shared security group arn id"
  value       = module.eks.node_security_group_id
}

output "cluster_iam_role_name" {
  description = "eks cluster iam role name"
  value       = module.eks.cluster_iam_role_name
}

output "cluster_iam_role_arn" {
  description = "eks cluster iam role arn"
  value       = module.eks.cluster_iam_role_arn
}

output "cluster_iam_role_unique_id" {
  description = "eks cluster iam role id"
  value       = module.eks.cluster_iam_role_unique_id
}

output "cluster_addons" {
  description = "map of attribute maps for all eks cluster addons enabled"
  value       = module.eks.cluster_addons
}

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.eks.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.eks.cloudwatch_log_group_arn
}

output "eks_managed_node_groups" {
  description = "map of attribute maps for all eks managed node groups created"
  value       = module.eks.eks_managed_node_groups
}

output "eks_managed_node_groups_autoscaling_group_names" {
  description = "list of the autoscaling group names created by eks managed node groups"
  value       = module.eks.eks_managed_node_groups_autoscaling_group_names
}

output "aws_auth_configmap_yaml" {
  description = "base aws-auth configmap containing roles used in cluster node groups"
  value       = module.eks.aws_auth_configmap_yaml
}