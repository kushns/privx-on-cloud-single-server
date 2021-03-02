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

variable "ssh_private_key_file" {
  type        = string
  description = "Private key path"
}

variable "ssh_pub_key_file" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Google compute Engine ssh public key file"
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