output "privx_external-ip" {
  value = google_compute_address.privx-static.address
}

output "database_password" {
  value = random_password.database_password.result
}

output "superuser_password" {
  value = random_password.superuser_password.result
}