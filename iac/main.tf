module "vpc" {
  source = "./modules/vpc"

  project_name = var.default_project_name
}

module "network" {
  source = "./modules/network"

  project_name   = var.default_project_name
  region_default = var.region_default

  vpc_id = module.vpc.vpc_id

  depends_on = [module.vpc]
}

module "sg" {
  source = "./modules/sg"

  project_name = var.default_project_name

  vpc_id = module.vpc.vpc_id

  depends_on = [module.vpc]
}

# tech-challenge-order

module "tech-challenge-order-rds" {
  source = "./modules/tech-challenge-order/rds"

  project_name         = var.tc_order_project_name
  db_postgres_username = var.tc_order_db_postgres_username
  db_postgres_password = var.tc_order_db_postgres_password
  db_postgres_database = var.tc_order_db_postgres_database

  security_group_id    = module.sg.sg_id
  db_subnet_group_name = module.network.db_subnet_group_name

  depends_on = [module.sg, module.network]
}

module "tech-challenge-order-secrets" {
  source = "./modules/tech-challenge-order/secrets"

  db_postgres_username = var.tc_order_db_postgres_username
  db_postgres_password = var.tc_order_db_postgres_password
  db_postgres_database = var.tc_order_db_postgres_database
  aws_rds_endpoint = module.tech-challenge-order-rds.rds_endpoint
  project_name = var.tc_order_project_name

  depends_on = [module.tech-challenge-order-rds]
}

# tech-challenge-user

module "tech-challenge-user-rds" {
  source = "./modules/tech-challenge-user/rds"

  project_name         = var.tc_user_project_name
  db_postgres_username = var.tc_user_db_postgres_username
  db_postgres_password = var.tc_user_db_postgres_password
  db_postgres_database = var.tc_user_db_postgres_database

  security_group_id    = module.sg.sg_id
  db_subnet_group_name = module.network.db_subnet_group_name
  parameter_group_name = module.tech-challenge-order-rds.parameter_group_name

  depends_on = [module.sg, module.network]
}

module "tech-challenge-user-elastic-cache" {
  source = "./modules/tech-challenge-user/elastic-cache"

  project_name = var.tc_user_project_name

  security_group_id = module.sg.sg_id
  subnet_group_name = module.network.cache_subnet_group_name

  depends_on = [module.sg, module.network]
}

module "tech-challenge-user-secrets" {
  source = "./modules/tech-challenge-user/secrets"

  db_postgres_username = var.tc_user_db_postgres_username
  db_postgres_password = var.tc_user_db_postgres_password
  db_postgres_database = var.tc_user_db_postgres_database

  aws_rds_endpoint           = module.tech-challenge-user-rds.rds_endpoint
  aws_elastic_cache_endpoint = module.tech-challenge-user-elastic-cache.redis_endpoint
  project_name = var.tc_user_project_name

  depends_on = [module.tech-challenge-user-rds, module.tech-challenge-user-elastic-cache]
}

module "tech-challenge-payment-atlas-mongodb" {
  source = "./modules/tech-challenge-payment/atlas-mongodb"

  cluster_instance_size_name = var.tc_payment_atlas_cluster_instance_size_name
  atlas_org_id               = var.tc_payment_atlas_org_id
  ip_address                 = var.tc_payment_atlas_ip_address
  atlas_region               = var.region_default
  cloud_provider             = var.tc_payment_atlas_cloud_provider
  atlas_project_name         = var.tc_payment_atlas_project_name
  db_postgres_username       = var.tc_payment_db_postgres_username
  db_postgres_password       = var.tc_payment_db_postgres_password
}

module "tech-challenge-payment-secrets" {
  source = "./modules/tech-challenge-payment/secrets"

  atlas_cluster_connection_string = module.tech-challenge-payment-atlas-mongodb.atlas_cluster_connection_string
  project_name                    = var.tc_payment_project_name
  depends_on                      = [module.tech-challenge-payment-atlas-mongodb]
}