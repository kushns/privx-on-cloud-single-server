terraform {
  required_version = ">=0.14.0"
  backend "remote" {
    organization = "ssh"

    workspaces {
      name = "privx-on-cloud-single-server"
    }
  }
}
