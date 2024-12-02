output "redis_endpoint" {
  description = "Endpoint do cluster Redis"
  value       = aws_elasticache_cluster.redis.configuration_endpoint
}

output "redis_security_group_id" {
  description = "ID do Security Group associado ao Redis"
  value       = aws_security_group.redis_sg.id
}