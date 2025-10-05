variable "aws_region" {
  default = "ap-south-1"
}

variable "app_name" {
  default = "strapi-app"
}

variable "ecs_service_desired_count" {
  default = 1
}

variable "db_username" {}
variable "db_password" {
  sensitive = true
}
