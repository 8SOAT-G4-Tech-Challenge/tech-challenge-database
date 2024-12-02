# Security Group
resource "aws_security_group" "redis_sg" {
  name        = "redis-sg"
  description = "Security group for Redis access"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidr_blocks
  }
}

# Subnets
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = [var.database_subnet_ids]

  tags = {
    Name = "TechChallengeRedisSubnetGroup"
  }
}

# Redis Cluster
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "tech-challenge-redis"
  engine               = "redis"
  node_type            = var.redis_node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  security_group_ids   = [aws_security_group.redis_sg.id]

  tags = {
    Name = "TechChallengeRedisCluster"
    Environment = var.elastic_cache_vars["environment"]
  }
}