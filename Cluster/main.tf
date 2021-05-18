##### VPC /SUbnet creation 

resource "google_compute_network" "vpc_network" {
  name = var.vpc_network
  mtu  = 1460
  auto_create_subnetworks = false
  
}

###creation of the 3 subnets for the network created above 
resource "google_compute_subnetwork" "network-with-private-ip-ranges" {
  name          = "pricepromo-central1"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       =  google_compute_network.vpc_network.id

}

resource "google_compute_subnetwork" "network-with-private-ip-ranges2" {
  name          = "df-east4"
  ip_cidr_range = "10.232.0.0/20"
  region        = "us-east4"
  network       =  google_compute_network.vpc_network.id

}

resource "google_compute_subnetwork" "network-with-private-ip-ranges3" {
  name          = "pricepromo-east4"
  ip_cidr_range = "172.22.186.0/24"
  region        = "us-east4"
  network       =  google_compute_network.vpc_network.id

}

##firewall rules 

resource "google_compute_firewall" "default" {
  name    = "commonsvc-pricepromo-prod-allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
   
  }
 source_ranges  = ["0.0.0.0/0"]
  ##source_tags = ["web"]
}


###cluster creation 
resource "google_container_cluster" "default" {
  name        = var.name
  project     = var.project
  description = "Demo GKE Cluster"
  location    = var.location
   min_master_version   =  "1.17.17-gke.2800"
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

   ##default_max_pods_per_node = 2
   cluster_ipv4_cidr = "10.254.0.0/16"
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.network-with-private-ip-ranges.id
    ###allowing external networks to conenct to this cluster ##
    master_authorized_networks_config {
        cidr_blocks {
            cidr_block   = "97.65.3.140/30"
          
        }
        cidr_blocks {
            cidr_block   = "97.65.3.144/31"
            
        }
    }
    # to enable the check of container images  validation  by Google Binary Authorization.
  enable_binary_authorization  = true
  ##The name of the RBAC security group for use with Google security groups in Kubernetes RBAC
  ##security_group = gke-security-groups@domainname.com

  ###to store resource consumption data in the dataset 
  /*
  resource_usage_export_config {
  enable_network_egress_metering = false
  enable_resource_consumption_metering = true

  bigquery_destination {
    dataset_id = "gke_usage_export"
  }
}
*/
}

resource "google_container_node_pool" "default" {
#  name       = "${var.name}-node-pool"
  name       =  each.value 
  for_each   = var.node_pool_name 
  project    = var.project
  location   = var.location
  cluster    = google_container_cluster.default.name
  node_count = 1
  
  node_config {
    preemptible  = true
    machine_type = var.machine_type
    
    metadata = {
      disable-legacy-endpoints = "true"
    
    }
  }
}