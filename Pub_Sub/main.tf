resource "google_pubsub_topic" "terraform_topic" {
  ###give topic name below 
  name = var.terraform-topic
}

resource "google_pubsub_subscription" "terraform_sub_1" {
  name  = var.terraform-topic-subscription1
  topic = google_pubsub_topic.terraform_topic.name

##7 days retention 
  message_retention_duration = var.message_retention_duration1
  retain_acked_messages      = var.retain_acked_messages1
  ack_deadline_seconds = var.ack_deadline_seconds1
##never expires expiration 
  expiration_policy {

    ttl = ""
  }
  retry_policy {
    minimum_backoff = var.minimum_backoff1
    maximum_backoff = var.maximum_backoff1
  }

  enable_message_ordering    = var.enable_message_ordering1
}

#####adddtion  of second subscription ### 

resource "google_pubsub_subscription" "terraform_sub_2" {
  name  = var.terraform-topic-subscription2
  topic = google_pubsub_topic.terraform_topic.name

##7 days retention 
  message_retention_duration = var.message_retention_duration2
  retain_acked_messages      = var.retain_acked_messages2
  ack_deadline_seconds = var.ack_deadline_seconds2
##never expires expiration 
  expiration_policy {

    ttl = ""
  }
  retry_policy {
    minimum_backoff = var.minimum_backoff2
    maximum_backoff = var.maximum_backoff2
  }

  enable_message_ordering    = var.enable_message_ordering2

}