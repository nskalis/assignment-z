data "aws_caller_identity" "current" {}

module "kms" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-kms.git?ref=5508c9c"

  aliases               = ["eks/${var.environment}-${var.proj_name}"]
  description           = "${var.environment}-${var.proj_name} cluster encryption key"
  enable_default_policy = true
  key_owners            = [data.aws_caller_identity.current.arn]

  tags = var.labels
}
