variable "region" {
  type        = string
  description = "AWS regin"
}

variable "key_name" {
  type        = string
  description = "AWS key pair name for SSH password less authentication"
}

variable "instance_type_privx" {
  default     = "t2.medium"
  type        = string
  description = "EC2 instance type for Privx"
}

variable "instance_type_privx_web" {
  default     = "t2.medium"
  type        = string
  description = "EC2 instance type for Privx_Web"
}

variable "ssh_private_key_file" {
  default     = "~/.ssh/id_rsa"
  type        = string
  description = "SSH Private key path for key name specified above"
}

variable "ssh_private_key_data" {
  default     = null
  type        = string
  description = "Private key data for terraform cloud, leave as null if using ssh_private_key_file"
}

variable "os_username" {
  default     = "ec2-user"
  type        = string
  description = "OS username on EC2 instnaces for which private key specified"
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