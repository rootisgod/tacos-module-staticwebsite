output "azurerm_static_website_url" {
    value = azurerm_storage_account.this.primary_web_endpoint
}