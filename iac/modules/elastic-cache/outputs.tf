output "redis_endpoint" {
  description = "Endpoint do cluster Redis"
  value       = try("${aws_elasticache_cluster.redis.cache_nodes[0].address}:${aws_elasticache_cluster.redis.cache_nodes[0].port}", "")
}

output "redis_security_group_id" {
  description = "ID do Security Group associado ao Redis"
  value       = aws_security_group.redis_sg.id
}