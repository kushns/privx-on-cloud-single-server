data "google_compute_network" "default" {
  name = "default"
}

resource "google_compute_address" "privx-static" {
  name = "privx-static"
}

resource "google_compute_address" "privx-web-static" {
  count = var.enable_web ? 1 : 0
  name  = "privx-web-static"
}