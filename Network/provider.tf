# Specify the provider (GCP, AWS, Azure)
provider "google" {
credentials = file("credentials.json")
project = "plucky-operand-312611"
region = "us-central1"
}