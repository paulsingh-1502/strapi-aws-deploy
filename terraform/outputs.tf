output "strapi_url" {
  description = "Public URL for Strapi"
  value       = "http://${aws_lb.strapi_alb.dns_name}"
}
