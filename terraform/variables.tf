variable "aws_region" {
  default = "ap-south-1"  # Change to your region
}

variable "app_name" {
  default = "strapi-app"
}

variable "container_port" {
  default = 1337
}

variable "desired_count" {
  default = 1
}
