variable "environment" {
  description = "name of the project's environment, used as a prefix"
  type        = string

  validation {
    condition     = can(regex("^labs$", var.environment))
    error_message = "invalid environment specified"
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

variable "jumphost_subnet_id" {
  description = "subnet id where jumphost resides in"
  type        = string
}

variable "ec2_key_pair_name" {
  description = "the key name for the key pair"
  type        = string
}

variable "ec2_private_key_filename" {
  description = "ec2 private key filename (ssh)"
  type        = string
}