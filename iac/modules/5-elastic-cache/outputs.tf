output "redis_endpoint" {
  description = "Endpoint do cluster Redis"
  value       = try("${aws_elasticache_cluster.redis.cache_nodes[0].address}:${aws_elasticache_cluster.redis.cache_nodes[0].port}", "")
}