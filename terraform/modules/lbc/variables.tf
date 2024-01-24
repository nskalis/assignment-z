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

variable "aws_region" {
  description = "aws region name where resources will be deployed"
  type        = string
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "cluster_name" {
  description = "eks cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "endpoint for kube-apiserver"
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = "certificate data required by kubernetes clients (base64 encoded)"
  type        = string
}

variable "oidc_provider_arn" {
  description = "open id connect provider arn"
  type        = string
}