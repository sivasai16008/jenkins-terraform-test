# Specify the provider (GCP, AWS, Azure)
provider "google" {
credentials = file("credentials.json")
project = "arctic-system-312209"
region = "us-central1"
}
