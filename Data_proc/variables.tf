

variable "vpc_network" {
  default = "commonsvc-pricepromo-prod-data-proc"
}

variable "name" {
  default = "dataproc-terraform-cluster"
}

variable "project" {
  default = "vivid-carrier-308607"
}

variable "location" {
  default = "us-central1"
}

variable "initial_node_count" {
  default = 1
}

variable "machine_type" {
  default = "n1-standard-1"
}