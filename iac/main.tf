module "network" {
  source = "./modules/network"

  network_vars = {
    project_name = var.project_name
    environment  = var.environment
    aws_region   = var.aws_region
  }
}

module "rds" {
  source = "./modules/rds"

  depends_on = [module.network]

  main_vpc_id          = module.network.main_vpc_id
  database_subnet_ids  = module.network.database_subnet_id
  db_postgres_username = var.db_postgres_username
  db_postgres_password = var.db_postgres_password
  db_postgres_database = var.db_postgres_database
}

module "elastic-cache" {
  source = "./modules/elastic-cache"

  depends_on = [module.network]

  main_vpc_id         = module.network.main_vpc_id
  database_subnet_ids = module.network.database_subnet_id
  elastic_cache_vars = {
    environment = var.environment
    aws_region  = var.aws_region
  }
}

module "secrets" {
  source = "./modules/secrets"

  depends_on = [
    module.network,
    module.rds,
    module.elastic-cache
  ]

  aws_rds_endpoint           = module.rds.rds_endpoint
  aws_elastic_cache_endpoint = module.elastic-cache.redis_endpoint
  db_postgres_username       = var.db_postgres_username
  db_postgres_password       = var.db_postgres_password
  db_postgres_database       = var.db_postgres_database
}