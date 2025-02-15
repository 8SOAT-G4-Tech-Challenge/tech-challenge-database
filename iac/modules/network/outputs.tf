output "private_subnet_ids" {
  value = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.database.name
}

output "cache_subnet_group_name" {
  value = aws_elasticache_subnet_group.cache.name
}