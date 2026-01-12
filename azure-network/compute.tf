resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name                = "web-vmss"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_B1s"
  instances           = 2
  admin_username      = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/azure_terraform_key.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  network_interface {
    name    = "webvmss-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.web_subnet.id

      load_balancer_backend_address_pool_ids = [
        azurerm_lb_backend_address_pool.web_backend_pool.id
      ]
    }
  }

  custom_data = base64encode(<<EOF
#cloud-config
package_update: true
packages:
  - nginx
runcmd:
  - systemctl enable nginx
  - systemctl start nginx
  - echo "<h1>Hello from VMSS instance $(hostname)</h1>" > /var/www/html/index.html
EOF
  )

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

resource "azurerm_virtual_machine_scale_set_extension" "node_app" {
  name                         = "nodejs-app"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.web_vmss.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.1"

  settings = jsonencode({
    fileUris = [
      "https://raw.githubusercontent.com/Poison-Iveey/terraform-web-deployment/main/scripts/install_node_app.sh"
    ]
    commandToExecute = "bash install_node_app.sh"
  })

  protected_settings = jsonencode({
    DB_HOST     = var.db_host
    DB_USER     = var.db_user
    DB_PASSWORD = var.db_password
    DB_NAME     = var.db_name
  })
}
