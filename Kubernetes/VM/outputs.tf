
output "virtual_machine" {
  value = google_compute_instance.default.name
}

##output "master_version" {
 ## value = google_container_cluster.default.master_version
#}
