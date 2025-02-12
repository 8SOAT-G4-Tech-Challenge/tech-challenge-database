# data "mongodbatlas_advanced_cluster" "atlas-cluser" {
#   project_id = mongodbatlas_project.atlas-project.id
#   name       = mongodbatlas_advanced_cluster.atlas-cluster.name
#   depends_on = [mongodbatlas_privatelink_endpoint_service.atlaseplink]
# }