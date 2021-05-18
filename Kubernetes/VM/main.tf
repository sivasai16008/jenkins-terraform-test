
##### VPC /SUbnet creation 

resource "google_compute_network" "vpc_network" {
  name = var.vpc_network
  mtu  = 1460
  auto_create_subnetworks = false
}

###creation of the  subnet for the network created above 
resource "google_compute_subnetwork" "subnetwork-with-private-ip-ranges" {
  name          = "pricepromo-central1"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       =  google_compute_network.vpc_network.id
}

resource "google_service_account" "default" {
  account_id   = "airflow-worker"
  display_name = "service account terraform vm"
}

##resource "google_compute_firewall" "http-server" {
  ##name    = "default-allow-http-terraform"
  ###network = var.vpc_network
  ##target_tags = [ "upmt-spark" ]
  ##allow {
    ##protocol = var.protocol
    ##ports    = [var.port]
  ##}
##}
resource "google_compute_instance" "default" {
  name         = var.machine_name
  machine_type = var.machine_type
  zone         = var.zone
  allow_stopping_for_update = true
  ####enable_vtpm = true
  tags = ["upmt-spark"]
network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnetwork-with-private-ip-ranges.id
    ##alias_ip_range = "10.254.5.0/24"
      
}
  boot_disk {
    initialize_params {
     image = var.machine_image
    }
  }

   service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"] 
    }

    ####metadata = {dataproc-bucket= "dataproc-staging-us-east4-82307030432-q7s50lxr"}
####cant  use  in local as machimne UEFI-enabled instance as platform used is diffrent in local free gcp account !!
  ##shielded_instance_config {
   ##enable_vtpm = true
   ##enable_integrity_monitoring = true
    ##}
    
    ###metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Avenue Code is the leading software consulting agency focused on delivering end-to-end development solutions for digital transformation across every vertical. We pride ourselves on our technical acumen, our collaborative problem-solving ability, and the warm professionalism of our teams.!</h1></body></html>' | sudo tee /var/www/html/index.html"
    metadata_startup_script = var.startup_script
    // Apply the firewall rule to allow external IPs to access this instance
    ###tags = [var.tags]
}


