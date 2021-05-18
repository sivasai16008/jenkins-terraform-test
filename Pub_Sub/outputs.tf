
output "Topic_created" {
  value = google_pubsub_topic.terraform_topic.name
}

output "Subscription1_created" {
  value = google_pubsub_subscription.terraform_sub_1.name
}

output "Subscription2_created" {
  value = google_pubsub_subscription.terraform_sub_2.name
}
