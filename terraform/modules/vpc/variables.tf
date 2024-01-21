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
