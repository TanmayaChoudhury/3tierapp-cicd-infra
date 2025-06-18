output "keyvault_id" {
  description = "The resource ID of the Key Vault."
  value       = azurerm_key_vault.kv.id
}

output "keyvault_name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.kv.name
}

output "keyvault_uri" {
  description = "The URI endpoint of the Key Vault."
  value       = azurerm_key_vault.kv.vault_uri
}
