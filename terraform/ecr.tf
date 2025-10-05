resource "aws_ecr_repository" "strapi" {
  name = "${var.app_name}-ecr-v2"
}
