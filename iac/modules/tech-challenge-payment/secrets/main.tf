resource "aws_secretsmanager_secret" "database_url" {
  name                    = "${var.project_name}-atlas-mongodb-endpoint"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id     = aws_secretsmanager_secret.database_url.id
  secret_string = var.atlas_cluster_connection_string
}