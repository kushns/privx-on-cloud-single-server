data "google_compute_network" "default" {
  name = "default"
}

resource "google_compute_address" "privx-static" {
  name = "privx-static"
}