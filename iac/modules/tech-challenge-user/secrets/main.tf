resource "aws_secretsmanager_secret" "database_url" {
  name                    = "${var.project_name}-aws-rds-endpoint"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id     = aws_secretsmanager_secret.database_url.id
  secret_string = "postgresql://${var.db_postgres_username}:${var.db_postgres_password}@${var.aws_rds_endpoint}/${var.db_postgres_database}"
}

resource "aws_secretsmanager_secret" "redis_url" {
  name                    = "aws_elastic_cache_endpoint"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "redis_url" {
  secret_id     = aws_secretsmanager_secret.redis_url.id
  secret_string = coalesce("redis://${var.aws_elastic_cache_endpoint}", "")

  depends_on = [aws_secretsmanager_secret.redis_url]
}