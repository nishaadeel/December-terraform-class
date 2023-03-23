resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
	
	metadata = {
		ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}ubuntu:${file("~/.ssh/id_rsa.pub")}"
}
}
