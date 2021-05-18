
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
resource "google_dataproc_cluster" "mycluster" {
  name     = "mycluster"
  region   = "us-central1"
  graceful_decommission_timeout = "120s"
 
  labels = {
    env  = "test"
    
  }

  cluster_config {
    ##staging_bucket = "dataproc-staging-bucket"

    master_config {
      num_instances = 1
      ##image_uri = "2.0-debian10"
      machine_type  = "n1-standard-2"
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
        
      }
    }
    gce_cluster_config {
      tags = ["nice", "cluster"]
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      ##service_account = google_service_account.default.email
      ##network    =  "commonsvc-pricepromo-prod"
      #network    =  "pricepromo-east4"
      ##subnetwork =  "pricepromo-central1"
      ##subnetwork = "https://www.googleapis.com/compute/v1/projects/vivid-carrier-308607/regions/us-central1/subnetworks/pricepromo-central1"
      ##network      =  google_compute_network.dataproc_network.name
      ##subnetwork =  "pricepromo-central1"
      ##service_account = "test-terraform@vivid-carrier-308607.iam.gserviceaccount.com"
      ##service_account_scopes = [
        ###"cloud-platform"
      ##]
    }
    worker_config {
      num_instances    = 2
      machine_type     = "n1-standard-2"
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_size_gb = 30
        
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version = "2.0-debian10"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }



    # You can define multiple initialization_action blocks
    ##initialization_action {
      ##script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
    ##  timeout_sec = 500
    ##}
  }
}