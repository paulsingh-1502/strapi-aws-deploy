output "alb_url" {
  description = "Public URL of Strapi"
  value       = aws_lb.strapi_alb.dns_name
}

output "db_endpoint" {
  description = "PostgreSQL endpoint"
  value       = aws_db_instance.postgres.address
}

output "ecr_repo" {
  value = aws_ecr_repository.strapi.repository_url
}
