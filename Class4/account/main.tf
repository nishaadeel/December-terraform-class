data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}


output  billing_account_name {
    value = data.google_billing_account.acct.name
}


resource "random_password" "password" {
	length = 16
	numeric = false
	special = false
	lower = true
	upper = false
}


resource "google_project" "testproject" {
	name = "testproject"
	project_id = random_password.password.result
	billing_account = data.google_billing_account.acct.id
}
