resource "azurerm_virtual_machine" "privx" {
  name                          = "privx-vm"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  network_interface_ids         = [azurerm_network_interface.privx-nic.id]
  vm_size                       = var.privx_vmsize
  delete_os_disk_on_termination = true
  depends_on                    = [azurerm_network_interface_security_group_association.privx]
  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_3-gen2"
    version   = "8.3.2020120901"
  }
  storage_os_disk {
    name              = "privxosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    admin_username = var.os_username
    computer_name  = var.privx_hostname
  }
  os_profile_linux_config {
    disable_password_authentication = "true"
    ssh_keys {
      key_data = var.ssh_pub_key_data == null ? file(var.ssh_pub_key_file) : var.ssh_pub_key_data
      path     = "/home/${var.os_username}/.ssh/authorized_keys"
    }
  }
  tags = {
    environment = "Privx-Poc"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo dnf install epel-release -y -q",
      "sudo rpm --import https://product-repository.ssh.com/info.fi-ssh.com-pubkey.asc",
      "sudo curl https://product-repository.ssh.com/rhel8/ssh-products.repo -o /etc/yum.repos.d/ssh-products.repo",
      "sudo dnf install -y -q PrivX",
      "cat <<EOF > config.sh",
      "export PRIVX_DNS_NAMES=\"${var.privx_hostname} ${azurerm_public_ip.privx-public.fqdn}\"",
      "export PRIVX_IP_ADDRESSES=\"${azurerm_network_interface.privx-nic.private_ip_address} ${azurerm_public_ip.privx-public.ip_address}\"",
      "export PRIVX_SUPERUSER=\"${var.privx_superuser}\"",
      "export PRIVX_SUPERUSER_PASSWORD=\"${random_password.superuser_password.result}\"",
      "export PRIVX_SUPERUSER_EMAIL=\"${var.privx_superuser}@example.com\"",
      "export PRIVX_USE_EXTERNAL_DATABASE=0",
      "export PRIVX_DATABASE_NAME=privx",
      "export PRIVX_DATABASE_USERNAME=privx",
      "export PRIVX_DATABASE_PASSWORD=\"${random_password.database_password.result}\"",
      "export PRIVX_DATABASE_SSLMODE=require",
      "export PRIVX_KEYVAULT_PKCS11_ENABLE=0",
      "export PRIVX_NTP_SERVER=pool.ntp.org",
      "/opt/privx/scripts/postinstall.sh",
      "EOF",
      "sudo bash config.sh",
      "rm -rf config.sh"
    ]
    connection {
      type        = "ssh"
      host        = azurerm_public_ip.privx-public.fqdn
      user        = var.os_username
      private_key = var.ssh_private_key_data == null ? file(var.ssh_private_key_file) : var.ssh_private_key_data
    }
  }
}
