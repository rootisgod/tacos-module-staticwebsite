resource "local_file" "index" {
    content  = "<!DOCTYPE html><HTML><HEAD><TITLE>${var.static_website_name}</TITLE><H1>THIS IS: ${var.static_website_name}</H1>"
    filename = "index.html"
}

resource "azurerm_storage_account" "this" {
  location                 = var.location
  resource_group_name      = var.resource_group_name
  name                     = var.static_website_name
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document     = "index.html"
    error_404_document = "error.html"
  }
}

# https://thomasthornton.cloud/2022/07/11/uploading-contents-of-a-folder-to-azure-blob-storage-using-terraform/
resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "index.html"
  content_type           = "text/html"
}