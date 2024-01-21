resource "aws_iam_policy" "additional" {
  name   = "${var.environment}-${var.proj_name}-additional"
  policy = file("${path.module}/../../environments/${var.environment}/files/ec2-describe-policy.json")

  tags = var.labels
}