resource "google_compute_instance" "privx" {
  name         = "privx"
  machine_type = var.machine_typeprivx
  zone         = var.zone

  tags = ["ssh", "web"]
  labels = {
    name = "privx"
  }

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
    }
  }

  network_interface {
    network = data.google_compute_network.default.name

    access_config {
      // Ephemeral IP
      nat_ip = google_compute_address.privx-static.address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install epel-release -y -q",
      "sudo rpm --import https://product-repository.ssh.com/info.fi-ssh.com-pubkey.asc",
      "sudo curl https://product-repository.ssh.com/rhel8/ssh-products.repo -o /etc/yum.repos.d/ssh-products.repo",
      "sudo dnf install -y -q PrivX",
      "cat <<EOF > config.sh",
      "export PRIVX_DNS_NAMES=\"${google_compute_address.privx-static.address}\"",
      "export PRIVX_IP_ADDRESSES=\"${self.network_interface[0].network_ip} ${google_compute_address.privx-static.address}\"",
      "export PRIVX_SUPERUSER=\"${var.privx_superuser}\"",
      "export PRIVX_SUPERUSER_PASSWORD=\"${random_password.superuser_password.result}\"",
      "export PRIVX_SUPERUSER_EMAIL=\"${var.privx_superuser}@example.com\"",
      "export PRIVX_USE_EXTERNAL_DATABASE=0",
      "export PRIVX_DATABASE_NAME=privx",
      "export PRIVX_DATABASE_USERNAME=privx",
      "export PRIVX_DATABASE_PASSWORD=\"${random_password.database_password.result}\"",
      "export PRIVX_DATABASE_SSLMODE=require",
      "export PRIVX_KEYVAULT_PKCS11_ENABLE=0",
      "export PRIVX_NTP_SERVER=pool.ntp.org",
      "/opt/privx/scripts/postinstall.sh",
      "EOF",
      "sudo bash config.sh",
      "rm -rf config.sh"
    ]
    connection {
      host        = self.network_interface[0].access_config[0].nat_ip
      user        = var.ssh_user
      private_key = file(var.ssh_private_key_file)
    }
  }
}
