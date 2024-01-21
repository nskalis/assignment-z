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

variable "labels" {
  description = "a map of names and values, used to tag terraform resources"
  type        = map(any)
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "vpc_private_networks_list" {
  description = "list of vpc private networks"
  type        = list(string)
}

variable "kube_version" {
  description = "eks version"
  type        = string

  validation {
    condition     = contains(["1.28", "1.27", "1.26", "1.25", "1.24"], var.kube_version)
    error_message = "not suppported kubernetes version"
  }
}

variable "kube_nodes_types" {
  description = "kubernetes worker nodes instance type"
  type        = list(string)

  validation {
    condition     = length(var.kube_nodes_types) >= 1
    error_message = "expecting a list of at least one instance type"
  }
}

variable "kube_nodes_count" {
  description = "number >=2 of kubernetes worker nodes (desired)"
  type        = number

  validation {
    condition     = var.kube_nodes_count >= 2
    error_message = "not suppported kubernetes version"
  }
}

variable "ec2_key_pair_name" {
  description = "the key name for the key pair"
  type        = string
}
