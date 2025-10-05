variable "region" {
  default = "ap-south-1"
}

variable "db_username" {
  description = "Username for the PostgreSQL database"
  type        = string
}

variable "db_password" {
  description = "Password for the PostgreSQL database"
  type        = string
  sensitive   = true
}

