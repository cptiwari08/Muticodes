resource "azurerm_subnet" "Bastion-block" {
    for_each = var.bastion_map
  name                 = each.value.bastion_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.bastion_address_prefixes
}

resource "azurerm_public_ip" "public-pip" {
  for_each = var.bastion_map
  name                = each.value.ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_bastion_host" "bastionhost-block" {
  for_each = var.bastion_map
  name                = "test-bastion"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "ip_cnfig"
    subnet_id            = data.azurerm_subnet.Bastion-block.id
    public_ip_address_id = data.azurerm_public_ip.public-pip.id
  }
}