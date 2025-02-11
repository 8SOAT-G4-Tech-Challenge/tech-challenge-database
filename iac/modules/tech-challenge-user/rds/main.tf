resource "aws_db_instance" "postgres" {
  allocated_storage = var.allocated_storage
  storage_type = var.storage_type
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  db_name = var.db_postgres_database
  username = var.db_postgres_username
  password = var.db_postgres_password
  port = var.port
  identifier = var.identifier
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot = var.skip_final_snapshot
  publicly_accessible    = true
	db_subnet_group_name = var.db_subnet_group_name
	vpc_security_group_ids = [var.security_group_id]

	tags = {
		Name = "${var.project_name}-postgres"
		Iac = true
	}
}