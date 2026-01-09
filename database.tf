# =========================
# Random suffix for globally unique server name
# =========================
resource "random_string" "suffix" {
  length  = 4
  upper   = false
  numeric = true
  special = false
}

# =========================
# Azure Private DNS Zone
# =========================
resource "azurerm_private_dns_zone" "postgres_dns" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# =========================
# Link Private DNS Zone to VNet
# =========================
resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_link" {
  name                  = "postgres-dns-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = true
}

# =========================
# PostgreSQL Flexible Server
# =========================
resource "azurerm_postgresql_flexible_server" "postgres_server" {
  name                = "myproject-postgres-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  version             = "13"

  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  administrator_login    = "dbadmin"
  administrator_password = "YourStrongP@ssword123" # replace with variable in production

  delegated_subnet_id           = azurerm_subnet.db_subnet.id
  public_network_access_enabled = false
  private_dns_zone_id           = azurerm_private_dns_zone.postgres_dns.id

  lifecycle {
    ignore_changes = [
      zone
    ]
  }
}

# =========================
# PostgreSQL Database
# =========================
resource "azurerm_postgresql_flexible_server_database" "mydb" {
  name      = "mydatabase"
  server_id = azurerm_postgresql_flexible_server.postgres_server.id
  charset   = "UTF8"
}

