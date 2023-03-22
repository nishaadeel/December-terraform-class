data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}


output  billing_account_name {
    value = data.google_billing_account.acct.name
}