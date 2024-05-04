data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "keyvault_name" {
  name                = "tiwari-secrets008"
  resource_group_name = "cptiwari-rg"
}

data "azurerm_key_vault_secret" "tiwari_username" {
  name         = "cptusername"
  key_vault_id = data.azurerm_key_vault.keyvault_name.id
}

data "azurerm_key_vault_secret" "tiwari_password" {
  name         = "cptpassword"
  key_vault_id = data.azurerm_key_vault.keyvault_name.id
}

