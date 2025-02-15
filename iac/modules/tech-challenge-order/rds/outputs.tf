output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "parameter_group_name" {
  value = aws_db_parameter_group.postgres_params.name
}