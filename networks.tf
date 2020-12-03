# VNets
resource "azurerm_virtual_network" "VNet-HUB" {
    resource_group_name = azurerm_resource_group.terraform-testing.name
    location = azurerm_resource_group.terraform-testing.location
    name = "terraform-hubvnet"
    address_space = [ var.iphubvnet ]
}

resource "azurerm_virtual_network" "VNet-Spoke1" {
    resource_group_name = azurerm_resource_group.terraform-testing.name
    location = azurerm_resource_group.terraform-testing.location
    name = "terraform-spokevnet1"
    address_space = [ var.ipspoke1vnet ]
}

resource "azurerm_virtual_network" "VNet-Spoke2" {
    resource_group_name = azurerm_resource_group.terraform-testing.name
    location = azurerm_resource_group.terraform-testing.location
    name = "terraform-spokevnet2"
    address_space = [ var.ipspoke2vnet ]
}

# Subnets
resource "azurerm_subnet" "Hub-Subnet-DMZ" {
    resource_group_name = azurerm_resource_group.terraform-testing.name
    name = "terraform-hub-dmz"
    virtual_network_name = azurerm_virtual_network.VNet-HUB.name
    address_prefixes = [ var.ipsubdmz ]
}

resource "azurerm_subnet" "Spoke1-Subnet" {
    resource_group_name = azurerm_resource_group.terraform-testing.name
    name = "terraform-spoke1"
    virtual_network_name = azurerm_virtual_network.VNet-Spoke1.name
    address_prefixes = [ var.ipsubsp1 ]
}

# Peering VNets
resource "azurerm_virtual_network_peering" "Peering-Hub-Spoke1" {
    resource_group_name = azurerm_resource_group.terraform-testing.name
    name = "terraform-hubtosp1"
    virtual_network_name = azurerm_virtual_network.VNet-HUB.name
    remote_virtual_network_id = azurerm_virtual_network.VNet-Spoke1.id
}
resource "azurerm_virtual_network_peering" "Peering-Spoke1-HUB" {
    resource_group_name = azurerm_resource_group.terraform-testing.name
    name = "terraform-sp1tohub"
    virtual_network_name = azurerm_virtual_network.VNet-Spoke1.name
    remote_virtual_network_id = azurerm_virtual_network.VNet-HUB.id
}

# NICs
resource "azurerm_network_interface" "terraform-linux-nic" {
    location = azurerm_resource_group.terraform-testing.location
    resource_group_name = azurerm_resource_group.terraform-testing.name
    name = "terraform-nic"
    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.Spoke1-Subnet.id
        private_ip_address_allocation = "Dynamic"
    }
}