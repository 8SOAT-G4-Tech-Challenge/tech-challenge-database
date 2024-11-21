module "rds" {
  source = "./modules/rds"

  db_postgres_username = var.db_postgres_username
  db_postgres_password = var.db_postgres_password
  db_postgres_database = var.db_postgres_database
}

module "secrets" {
  source = "./modules/secrets"

  depends_on = [
    module.rds
  ]

  aws_rds_endpoint     = module.rds.rds_endpoint
  db_postgres_username = var.db_postgres_username
  db_postgres_password = var.db_postgres_password
  db_postgres_database = var.db_postgres_database
}