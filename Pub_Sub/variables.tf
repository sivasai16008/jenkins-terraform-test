
variable "terraform-topic" {
  type = string
  default = "terraform-sample-topic"
}

variable "terraform-topic-subscription1" {
  type = string
  default = "terraform-sample-subscription1"
}


variable "message_retention_duration1" {
  type = string
  default = "604800s"
}

variable "retain_acked_messages1" {
  type = bool
  default = false
}

variable "ack_deadline_seconds1" {
  type = number
  default = 10
}

variable "minimum_backoff1" {
  type = string
  default = "10s"
}

variable "maximum_backoff1" {
  type = string
  default = "600s"
}

variable "enable_message_ordering1" {
  type = bool
  default = true
}

###vars for second subscription 


variable "terraform-topic-subscription2" {
  type = string
  default = "terraform-sample-subscription2"
}


variable "message_retention_duration2" {
  type = string
  default = "604800s"
}

variable "retain_acked_messages2" {
  type = bool
  default = false
}

variable "ack_deadline_seconds2" {
  type = number
  default = 10
}

variable "minimum_backoff2" {
  type = string
  default = "10s"
}

variable "maximum_backoff2" {
  type = string
  default = "600s"
}

variable "enable_message_ordering2" {
  type = bool
  default = true
}