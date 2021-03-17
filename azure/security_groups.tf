resource "azurerm_network_security_group" "privx-nsg" {
  name                = "privx-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Privx-Poc-ssh"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Privx-Poc-https"
    priority                   = 1020
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Privx-Poc-http"
    priority                   = 1030
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Privx-Poc"
  }
}

resource "azurerm_network_interface_security_group_association" "privx" {
  network_security_group_id = azurerm_network_security_group.privx-nsg.id
  network_interface_id      = azurerm_network_interface.privx-nic.id
}

resource "azurerm_network_security_group" "privx-web-nsg" {
  count               = var.enable_web ? 1 : 0
  name                = "privx-web-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Privx-Poc-ssh"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Privx-Web"
  }
}

resource "azurerm_network_interface_security_group_association" "privx-web" {
  count                     = var.enable_web ? 1 : 0
  network_security_group_id = azurerm_network_security_group.privx-web-nsg[0].id
  network_interface_id      = azurerm_network_interface.privx-web-nic[0].id
}