variable "region" {
  type        = string
  description = "Azure region"
}

variable "privx_vmsize" {
  default     = "Standard_DS1_v2"
  type        = string
  description = "Azure VM type for Privx"
}

variable "ssh_pub_key_file" {
  type        = string
  description = "SSH public key path to setup password less authentication"
}

variable "ssh_private_key_file" {
  type        = string
  description = "SSH Private key path for above mentioned public key"
}

variable "privx_superuser" {
  default     = "admin"
  type        = string
  description = "Privx superuser name"
}

variable "os_username" {
  default     = "centos"
  type        = string
  description = "OS username on Azure VM to setup password less authentication"
}

variable "privx_hostname" {
  default     = "privx.example.com"
  type        = string
  description = "Hostname for PrivX Azure VM"
}
