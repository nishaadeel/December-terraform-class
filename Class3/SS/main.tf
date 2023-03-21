resource "azurerm_resource_group" "example" {
  name     = "example-resources-ss"
  location = "West Europe"
}

output rg_id  {
    value = azurerm_resource_group.example.id
}


output rg_name  {
    value = azurerm_resource_group.example.name
}


output rg_location  {
    value = azurerm_resource_group.example.location
}


resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                = "example-vmss"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.internal.id
    }
  }
}


output ss_id {
    value = azurerm_linux_virtual_machine_scale_set.example.id
}


output ss_unique_id {
    value = azurerm_linux_virtual_machine_scale_set.example.unique_id
}

# output  ANYNAME { 
#     value = RESOURCE_TYPE.TERRAFORM_RESOURCE_NAME.filter
# }