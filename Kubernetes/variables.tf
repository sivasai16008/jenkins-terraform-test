

variable "vpc_network" {
  default = "commonsvc-pricepromo-prod"
}

variable "name" {
  default = "webapp"
}

variable "project" {
  default = "plucky-operand-312611"
}

variable "location" {
  default = "us-central1"
}


variable labels {
  type = map
  default = {
    "app" = "webapp"
  }
}

variable replicas {
  type        = number
  default     = 3
}

variable port {
  type        = number
  default     = 80
}
variable node_port {
  type        = number
  default     = 30201
}
variable target_port {
  type        = number
  default     = 80
}

variable image {
  type        = string
  default     = "nginx"
}

variable limits {
  type = map
  default = {
    "cpu"    = "0.5"
    "memory" = "512Mi"
  }
}

variable requests {
  type = map
  default = {
    "cpu"    = "250m"
    "memory" = "50Mi"
  }
}

variable hpa_replicas_max {
  type        = number
  default     = 8
}
variable hpa_replicas_min {
  type        = number
  default     = 5
}
