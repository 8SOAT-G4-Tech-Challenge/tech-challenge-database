resource "aws_secretsmanager_secret" "database_url" {
  name = "database/url"
}

resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id     = aws_secretsmanager_secret.database_url.id
  secret_string = "postgresql://${var.db_postgres_username}:${var.db_postgres_password}@${var.aws_rds_endpoint}/${var.db_postgres_database}"
}