variable "region" {
  type        = string
  description = "Azure region"
}

variable "privx_vmsize" {
  default     = "Standard_DS1_v2"
  type        = string
  description = "Azure VM type for Privx"
}

variable "privx_web_vmsize" {
  default     = "Standard_DS1_v2"
  type        = string
  description = "Azure VM type for Privx Web"
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

variable "privx_web_hostname" {
  default     = "privx-web.example.com"
  type        = string
  description = "Hostname for PrivX Azure VM"
}

variable "enable_web" {
  default     = false
  type        = bool
  description = "Launch and configure additional machine for Web http/https"
}