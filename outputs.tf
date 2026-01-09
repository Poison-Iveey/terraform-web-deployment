output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db_subnet.id
}

output "load_balancer_public_ip" {
  value       = azurerm_public_ip.lb_public_ip.ip_address
  description = "Public IP address of the Load Balancer"
}

output "lb_public_ip" {
  value       = azurerm_public_ip.lb_public_ip.ip_address
  description = "The public IP address of the Load Balancer"
}
