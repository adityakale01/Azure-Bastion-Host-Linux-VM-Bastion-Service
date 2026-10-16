resource "azurerm_public_ip" "bastion_service_ip" {
  name                = "${var.prefix}-bastion-service-ip"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"   # Bastion requires Static
  sku                 = "Standard" # Bastion requires Standard
}

resource "azurerm_bastion_host" "bastion_service" {
  name                = "${var.prefix}-bastion-service"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Basic"

  ip_configuration {
    name                 = "bastion-ipconfig"
    subnet_id            = azurerm_subnet.bastion_service.id
    public_ip_address_id = azurerm_public_ip.bastion_service_ip.id
  }
}
