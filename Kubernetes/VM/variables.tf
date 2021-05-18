##variable "image" {default = "debian-cloud/debian-9"}

variable "machine_name" {
  type = string
  default = "virtual-machine-from-terraform"
}

variable "machine_image" {
  type = string
  default = "debian-cloud/debian-9"
}

variable "machine_type" {
  type = string
  ##default = "f1-micro"
  default = "n1-standard-4"
}

variable "zone" {
  type = string
  default = "us-central1-a"
}

variable "vpc_network" {
  type = string
  default = "commonsvc-pricepromo-prod"
}

variable "subnetwork-with-private-ip-ranges" {
  type = string
  default = "pricepromo-central1"
}


variable "tags" {
  type = string
  default = "default"
}



variable "startup_script" {
  type = string
  default = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>Avenue Code is the leading software consulting agency focused on delivering end-to-end development solutions for digital transformation across every vertical. We pride ourselves on our technical acumen, our collaborative problem-solving ability, and the warm professionalism of our teams.!</h1></body></html>' | sudo tee /var/www/html/index.html"
}
variable "protocol" {
  type = string
  default = "tcp"
}

variable "port" {
  type = number
  default = "80"
}

variable "source_ranges" {
  type = string
  default = "0.0.0.0/0"
}

variable "target_tags" {
  type = string
  default = "http-server"
}


