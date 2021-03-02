# AWS
output "aws-privx-public-dns" {
  value = join("", ["https://", module.aws.privx-public-dns])
}

output "aws-database_password" {
  value = module.aws.database_password
}

output "aws-superuser_password" {
  value = module.aws.superuser_password
}


# Azure
output "azure-privx-public-dns" {
  value = join("", ["https://", module.azure.privx-public-dns])
}

output "azure-database_password" {
  value = module.azure.database_password
}

output "azure-superuser_password" {
  value = module.azure.superuser_password
}


# GCP
output "gcloud-privx-external-ip" {
  value = join("", ["https://", module.gcloud.privx_external-ip])
}

output "gcloud-database_password" {
  value = module.gcloud.database_password
}

output "gcloud-superuser_password" {
  value = module.gcloud.superuser_password
}