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

