output "privx-public-dns" {
  value = aws_instance.privx.public_dns
}

output "privx-web-public-dns" {
  value = var.enable_web ? aws_instance.privx-web[0].public_dns : ""
}

output "database_password" {
  value = random_password.database_password.result
}

output "superuser_password" {
  value = random_password.superuser_password.result
}
