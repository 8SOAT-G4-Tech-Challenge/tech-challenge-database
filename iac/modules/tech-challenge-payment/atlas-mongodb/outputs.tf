output "atlas_cluster_connection_string" { 
  value = "mongodb+srv://${mongodbatlas_database_user.db-user.username}:${random_password.db-user-password.result}@${mongodbatlas_cluster.atlas-cluster.name}.mongodb.net?retryWrites=true&w=majority"
}
output "ip_access_list" { value = mongodbatlas_project_ip_access_list.ip.ip_address }
output "project_name" { value = mongodbatlas_project.atlas-project.name }
output "username" { value = mongodbatlas_database_user.db-user.username }
output "user_password" {
  sensitive = true
  value     = mongodbatlas_database_user.db-user.password
}