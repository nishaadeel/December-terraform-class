provider "google" {
	region = var.asg_config["region"]
	zone = var.asg_config["zone"]
}
