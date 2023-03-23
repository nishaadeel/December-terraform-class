resource "random_string" "random" {
	length = 14
	special = false
	upper = false
}



resource "google_storage_bucket" "static-site" {
  name          = "bucket-terraform-${random_string.random.result}"
  location = "US"
  force_destroy = true
}