resource "aws_security_group" "postgres_sg" {
  name        = "postgres_public_access"
  description = "Allow postgres inbound traffic"
	vpc_id      = var.main_vpc_id

  ingress {
    description = "Postgres from anywhere"
    from_port   = 5432
    to_port     = 5432
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

resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "postgres-subnet-group"
  subnet_ids = var.database_subnet_ids
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
  publicly_accessible    = false
	db_subnet_group_name = aws_db_subnet_group.postgres_subnet_group.name
	vpc_security_group_ids = [aws_security_group.postgres_sg.id]
}

resource "aws_db_parameter_group" "postgres_params" {
  family = "postgres16"
  name   = "postgres16-params"
}
