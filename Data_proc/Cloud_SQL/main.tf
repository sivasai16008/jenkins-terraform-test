module "sql_example_postgres-private-ip" {
  source  = "gruntwork-io/sql/google//examples/postgres-private-ip"
  version = "0.5.0"
  # insert the 6 required variables here
  master_user_name = "expostgres"
  name_prefix = "db"
  master_user_password = "expostgres@123"
  project = var.project
  region = "us-central1"
  db_name = "default"
  machine_type = "db-f1-micro"
  postgres_version = "POSTGRES_9_6"
}	