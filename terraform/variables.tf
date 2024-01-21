variable "environment" {
  description = "name of the project's environment, used as a prefix"
  type        = string

  validation {
    condition     = can(regex("^labs$", var.environment))
    error_message = "invalid environment specified"
  }
}

variable "proj_name" {
  description = "name of the project infrastructure, used as a prefix"
  type        = string

  validation {
    condition     = can(regex("^z$", var.proj_name))
    error_message = "invalid project name specified"
  }
}

variable "aws_region" {
  description = "aws region name where resources will be deployed"
  type        = string
}

variable "aws_profile" {
  description = "aws configuration profile"
  type        = string
}

variable "vpc_network" {
  description = "ip network allocation for vpc management"
  type        = string
}

variable "vpc_public_networks_list" {
  description = "list of vpc public networks"
  type        = list(string)
}

variable "vpc_private_networks_list" {
  description = "list of vpc private networks"
  type        = list(string)
}

variable "ec2_private_key_filename" {
  description = "ec2 private key filename (ssh)"
  type        = string
}

variable "ec2_key_pair_name" {
  description = "ec2 key pair (ssh)"
  type        = string
}

variable "kube_version" {
  description = "eks version"
  type        = string
}

variable "kube_nodes_types" {
  description = "kubernetes worker nodes instance types"
  type        = list(string)
}

variable "kube_nodes_count" {
  description = "number >=2 of kubernetes worker nodes (desired)"
  type        = number
}
