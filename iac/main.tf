/* module "network" {
  source = "./modules/network"

  # eks_security_group_id = data.terraform_remote_state.eks.outputs.cluster_security_group_id
  network_vars = {
    project_name = var.project_name
    environment  = var.environment
    aws_region   = var.aws_region
  }
} */

module "rds" {
  source = "./modules/rds"
  db_postgres_username = var.db_postgres_username
  db_postgres_password = var.db_postgres_password
  db_postgres_database = var.db_postgres_database
}

module "elastic-cache" {
  source = "./modules/elastic-cache"

  elastic_cache_vars = {
    environment = var.environment
    aws_region  = var.aws_region
  }
}

module "secrets" {
  source = "./modules/secrets"

  depends_on = [
    module.rds,
    module.elastic-cache
  ]

  aws_rds_endpoint           = module.rds.rds_endpoint
  aws_elastic_cache_endpoint = module.elastic-cache.redis_endpoint
  db_postgres_username       = var.db_postgres_username
  db_postgres_password       = var.db_postgres_password
  db_postgres_database       = var.db_postgres_database
}