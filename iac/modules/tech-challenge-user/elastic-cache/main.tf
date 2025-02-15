resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "tech-challenge-redis"
  engine               = "redis"
  node_type            = var.redis_node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  subnet_group_name    = var.subnet_group_name
  security_group_ids   = [var.security_group_id]

  tags = {
    Name = "${var.project_name}-redis"
    Iac  = true
  }
}