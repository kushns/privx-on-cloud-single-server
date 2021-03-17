variable "project-id" {
  type        = string
  description = "GCP project id"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "zone" {
  type        = string
  description = "GCP zone"
}

variable "machine_typeprivx" {
  default     = "e2-medium"
  type        = string
  description = "machine type for Privx"
}

variable "machine_typeprivxweb" {
  default     = "e2-medium"
  type        = string
  description = "machine type for Privx Web"
}

variable "ssh_pub_key_file" {
  default     = "~/.ssh/id_rsa.pub"
  type        = string
  description = "SSH public key path to setup password less authentication"
}

variable "ssh_pub_key_data" {
  default     = null
  type        = string
  description = "SSH public key data for terraform cloud, leave as null if using ssh_pub_key_file"
}

variable "ssh_private_key_file" {
  default     = "~/.ssh/id_rsa"
  type        = string
  description = "SSH Private key path"
}

variable "ssh_private_key_data" {
  default     = null
  type        = string
  description = "SSH Private key data for terraform cloud, leave as null if using ssh_private_key_file"
}

variable "ssh_user" {
  default     = "centos"
  type        = string
  description = "OS username on Virtual machine for which private key specified"
}

variable "privx_superuser" {
  default     = "admin"
  type        = string
  description = "Privx superuser name"
}

variable "enable_web" {
  default     = false
  type        = bool
  description = "Launch and configure additional machine for Web http/https"
}