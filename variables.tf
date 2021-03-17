# Aws variables
variable "aws_region" {
  default     = null
  type        = string
  description = "AWS region"
}

variable "key_name" {
  default     = null
  type        = string
  description = "AWS key pair name for SSH password less authentication"
}

variable "aws_instance_type" {
  default     = "t2.medium"
  type        = string
  description = "EC2 instance type for Privx"
}

variable "aws_instance_type_web" {
  default     = "t2.medium"
  type        = string
  description = "EC2 instance type for Privx_Web"
}

# Azure variables
variable "azure_region" {
  default     = null
  type        = string
  description = "Azure region"
}

variable "azure_vmsize" {
  default     = "Standard_DS1_v2"
  type        = string
  description = "Azure VM type for Privx"
}

variable "azure_web_vmsize" {
  default     = "Standard_DS1_v2"
  type        = string
  description = "Azure VM type for Privx Web"
}

# GCP variables
variable "gcp_project_id" {
  default     = null
  type        = string
  description = "GCP project id"
}

variable "gcp_region" {
  default     = null
  type        = string
  description = "GCP region"
}

variable "gcp_zone" {
  default     = null
  type        = string
  description = "GCP zone"
}

variable "gcp_machine_type" {
  default     = "e2-medium"
  type        = string
  description = "GCP machine type for Privx"
}

variable "gcp_machine_type_web" {
  default     = "e2-medium"
  type        = string
  description = "GCP machine type for Privx Web"
}

# Common variables
variable "privx_superuser" {
  default     = "admin"
  type        = string
  description = "Privx superuser name"
}

variable "ssh_pub_key_file" {
  default     = "~/.ssh/id_rsa.pub"
  type        = string
  description = "SSH public key path to setup password less authentication"
}

variable "ssh_private_key_file" {
  default     = "~/.ssh/id_rsa"
  type        = string
  description = "SSH Private key path for above mentioned public key"
}

variable "ssh_pub_key_data" {
  default     = null
  type        = string
  description = "SSH public key data for terraform cloud, leave as null if using ssh_pub_key_file"
}

variable "ssh_private_key_data" {
  default     = null
  type        = string
  description = "SSH Private key data for terraform cloud, leave as null if using ssh_private_key_file"
}

variable "enable_web" {
  default     = false
  type        = bool
  description = "Launch and configure additional machine for Web http/https"
}
