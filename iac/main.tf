module "vpc" {
  source = "./modules/1-vpc"

  project_name = var.project_name
}

module "network" {
  source = "./modules/2-network"

  project_name   = var.project_name
  region_default = var.region_default

  vpc_id = module.vpc.vpc_id

	depends_on = [module.vpc]
}

module "sg" {
  source = "./modules/3-sg"

  project_name = var.project_name

  vpc_id = module.vpc.vpc_id

	depends_on = [module.vpc]
}

module "rds" {
  source = "./modules/4-rds"

  project_name         = var.project_name
  db_postgres_username = var.db_postgres_username
  db_postgres_password = var.db_postgres_password
  db_postgres_database = var.db_postgres_database

  security_group_id    = module.sg.sg_id
  db_subnet_group_name = module.network.db_subnet_group_name

	depends_on = [module.sg, module.network]
}

module "elastic-cache" {
  source = "./modules/5-elastic-cache"

  project_name = var.project_name

  security_group_id = module.sg.sg_id
  subnet_group_name = module.network.cache_subnet_group_name

	depends_on = [module.sg, module.network]
}

module "secrets" {
  source = "./modules/6-secrets"

  db_postgres_username = var.db_postgres_username
  db_postgres_password = var.db_postgres_password
  db_postgres_database = var.db_postgres_database

  aws_rds_endpoint           = module.rds.rds_endpoint
  aws_elastic_cache_endpoint = module.elastic-cache.redis_endpoint
  
	depends_on = [module.rds, module.elastic-cache]
}