resource "aws_security_group" "postgres" {
  name        = "postgres_public_access"
  description = "Allow postgres inbound traffic"

  ingress {
    description = "Postgres from anywhere"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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
  parameter_group_name = aws_db_parameter_group.postgres_params.name
  skip_final_snapshot = var.skip_final_snapshot
  publicly_accessible    = true
	vpc_security_group_ids = [aws_security_group.postgres.id]
}

resource "aws_db_parameter_group" "postgres_params" {
  family = "postgres16"
  name   = "postgres16-params"
}
