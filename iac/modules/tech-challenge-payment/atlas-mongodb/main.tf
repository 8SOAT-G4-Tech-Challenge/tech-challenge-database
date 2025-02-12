resource "mongodbatlas_project" "atlas-project" {
  org_id = var.atlas_org_id
  name = var.atlas_project_name
}

resource "mongodbatlas_database_user" "db-user" {
  username = var.db_postgres_username
  password = var.db_postgres_password
  project_id = mongodbatlas_project.atlas-project.id
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

# resource "mongodbatlas_advanced_cluster" "atlas-cluster" {
#   project_id = mongodbatlas_project.atlas-project.id
#   name = "${var.atlas_project_name}-cluster"
#   cluster_type = "REPLICASET"
  # replication_specs {
  #   region_configs {
  #     electable_specs {
  #       instance_size = var.cluster_instance_size_name
  #     }
  #     priority      = 7
  #     provider_name = var.cloud_provider
  #     region_name   = "US_EAST_1"
  #   }
  # }
# }

resource "mongodbatlas_cluster" "atlas-cluster" {
  project_id              = mongodbatlas_project.atlas-project.id
  name                    = "${var.atlas_project_name}-cluster"

  # Provider Settings "block"
  provider_name = "TENANT"
  backing_provider_name = var.cloud_provider
  provider_region_name = "US_EAST_1"
  provider_instance_size_name = var.cluster_instance_size_name
}