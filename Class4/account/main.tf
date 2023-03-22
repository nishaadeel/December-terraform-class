# Read Billing account info
data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

# print out billing account name
output "billing_account_name" {
  value = data.google_billing_account.acct.name
}

# generate 16 character string 
resource "random_password" "password" {
  length  = 16
  numeric = false
  special = false
  lower   = true
  upper   = false
}

# Create gcp project
resource "google_project" "testproject" {
  name            = "testproject"
  project_id      = random_password.password.result
  billing_account = data.google_billing_account.acct.id
}

# Set terminal to this project above
resource "null_resource" "set-project" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "gcloud config set project ${google_project.testproject.project_id}"
  }
}

# when destroyed unset project
resource "null_resource" "unset-project" {
  provisioner "local-exec" {
    when    = destroy
    command = "gcloud config unset project"
  }
}

# Enable list of services
resource "null_resource" "enable-apis" {
  depends_on = [
    google_project.testproject,
    null_resource.set-project
  ]
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = <<-EOT
        gcloud services enable compute.googleapis.com
        gcloud services enable dns.googleapis.com
        gcloud services enable storage-api.googleapis.com
        gcloud services enable container.googleapis.com
        gcloud services enable file.googleapis.com
    EOT
  }
}