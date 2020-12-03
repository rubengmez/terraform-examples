resource "azurerm_linux_virtual_machine" "linux-terraform" {
    location = azurerm_resource_group.terraform-testing.location
    resource_group_name = azurerm_resource_group.terraform-testing.name
    name = "terraform-linux"
    size = "Standard_B1s"
    network_interface_ids = [ azurerm_network_interface.terraform-linux-nic.id]
    disable_password_authentication = false
    admin_username = "terraformtesting"
    admin_password = "Terraformtesting1$"
    os_disk {
        storage_account_type = "Premium_LRS"
        caching = "None"
    }
    source_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "18.04-LTS"
        version = "latest"
    }
}