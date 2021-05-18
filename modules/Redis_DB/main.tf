///network  for redis db 

resource "google_compute_network" "vpc_network" {
  name = var.vpc_network
  mtu  = 1460
  auto_create_subnetworks = false
  
}
###creation of the  subnet for the network created above 
resource "google_compute_subnetwork" "network-with-private-ip-ranges" {
  name          = "pricepromo-central1"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       =  google_compute_network.vpc_network.id
   

}

######for private auth 

resource "google_compute_global_address" "service_range" {
  name          = "address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_service_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.service_range.name]
}

############################################################
resource "google_redis_instance" "cache" {
  name           = "ha-memory-cache-terrafrom-redis"
  ###standard high avialbility  or basic  
  tier           = "STANDARD_HA"
  memory_size_gb = 1
  location_id             = "us-central1-a"
  alternative_location_id = "us-central1-f"
  authorized_network = google_compute_network.vpc_network.id
  ##port = 6379
  redis_version     = "REDIS_5_0"
  display_name      = "Terraform Test Instance"
  ##reserved_ip_range = "192.168.0.0/29"
  ##reserved_ip_range = "10.255.241.3
  auth_enabled = true
  ##transit_encryption_mode = true 
  labels = {
    redis_db    = "redis_for_non_prod_upm"
  }
  redis_configs = {
    #nodes = 2
    ##stream-node-max-bytes = 
  }
 depends_on = [google_service_networking_connection.private_service_connection]
}
