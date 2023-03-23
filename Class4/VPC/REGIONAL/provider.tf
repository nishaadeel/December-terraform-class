provider "google" {
	region = var.vpc_config["region"]
	zone = var.vpc_config["zone"]
}
