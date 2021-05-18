# Specify the provider (GCP, AWS, Azure)
provider "google" {
credentials = file("credentials.json")
project = "vivid-carrier-308607"
region = "us-central1"
}