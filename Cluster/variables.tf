

variable "vpc_network" {
  default = "commonsvc-pricepromo-prod"
}

variable "name" {
  default = "demo-cluster"
}

variable "project" {
  default = "plucky-operand-312611"
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

variable "node_pool_name" {
  type  = set(string)
  default =  ["node-pool-2"]
}