
###applyyng roles to existing account 
##resource "google_project_iam_binding" "project" {
  ##project = var.project1
  ##role   = var.role2
  ##members = [
    ##"serviceAccount:test-terraform@vivid-carrier-308607.iam.gserviceaccount.com",
  ##]
##} 






module "projects_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 6.4"
  projects = [var.project]
  bindings = {
    "roles/storage.admin" = [
      ##"serviceAccount:google_service_account.default.id",
      "serviceAccount:test-terraform@vivid-carrier-308607.iam.gserviceaccount.com",
      
    ]

    "roles/compute.networkAdmin" = [
      "serviceAccount:test-terraform@vivid-carrier-308607.iam.gserviceaccount.com",
    ]

    "roles/compute.imageUser" = [
      "serviceAccount:test-terraform@vivid-carrier-308607.iam.gserviceaccount.com",
    ]
  }
}