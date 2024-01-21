locals {
  common_tags = {
    environment = var.environment
    proj_name   = var.proj_name
    terraform   = "true"
  }
}