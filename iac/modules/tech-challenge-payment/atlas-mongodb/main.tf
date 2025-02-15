resource "mongodbatlas_project" "atlas-project" {
  org_id = var.atlas_org_id
  name   = var.atlas_project_name
}

resource "mongodbatlas_database_user" "db-user" {
  username           = var.db_mongo_username
  password           = random_password.db-user-password.result
  project_id         = mongodbatlas_project.atlas-project.id
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = "${var.atlas_project_name}-db"
  }
}

resource "mongodbatlas_project_ip_access_list" "ip" {
  project_id = mongodbatlas_project.atlas-project.id
  ip_address = var.ip_address
}

resource "mongodbatlas_cluster" "atlas-cluster" {
  project_id = mongodbatlas_project.atlas-project.id
  name       = "${var.atlas_project_name}-cluster"

  provider_name               = "TENANT"
  backing_provider_name       = var.cloud_provider
  provider_region_name        = "US_EAST_1"
  provider_instance_size_name = var.cluster_instance_size_name
}

resource "random_password" "db-user-password" {
  length           = 16
  special          = true
  override_special = "_%@"
}