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

variable "ec2_private_key_filename" {
  description = "ec2 private key filename (ssh)"
  type        = string
}

variable "ec2_key_pair_name" {
  description = "ec2 key pair (ssh)"
  type        = string
}