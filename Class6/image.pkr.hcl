# Download plugins
packer {
	required_plugins {
		amazon = {
			version = ">= 0.0.1"
			source = "github.com/hashicorp/amazon"
		}
	}
}


# Prepare AMI
source "amazon-ebs" "image" {
	ami_name             = "golden-image {{timestamp}}"
	ssh_private_key_file = "/home/ec2-user/.ssh/id_rsa"
	ssh_keypair_name     = "packer"
	instance_type        = "t2.micro"
	ssh_username         = "ec2-user"
	region               = "us-east-2"
	source_ami = "ami-02f97949d306b597a"
	run_tags = {
		Name = "Packer instance for golden-image"
	}
}



# Build Machine
build {
	sources = [
		"source.amazon-ebs.image"
	]
	provisioner "shell" {
		inline = [
			"echo Installing Telnet",
            "sudo yum update -y",
			"sudo yum install telnet -y",
            "sudo useradd ansible"
		]
	}
	provisioner "breakpoint" {
		note = "Waiting for your verification"
	}
}