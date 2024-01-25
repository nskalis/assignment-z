resource "aws_iam_policy" "ec2_describe" {
  name   = "${var.environment}-${var.proj_name}-application-hug-iam-policy"
  policy = file("${path.module}/../../environments/${var.environment}/files/ec2-describe-iam-policy.json")

  tags = var.labels
}

module "application_iam_role" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-role-for-service-accounts-eks?ref=cbb39cb"

  role_name = "${var.environment}-${var.proj_name}-application-hug-iam-role"
  role_policy_arns = {
    policy = aws_iam_policy.ec2_describe.arn
  }
  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["hug:hug"]
    }
  }

  tags = var.labels
}
