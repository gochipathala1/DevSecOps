locals {
  vm_custom_data = <<-CUSTOM_DATA
    #!/bin/sh
    sudo yum install -y httpd
    sudo systemctl enable httpd
    sudo systemctl start httpd
    CUSTOM_DATA
}

resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  count               = var.vm-count
  name                = "linuxvm-${count.index}"
  resource_group_name = var.resource_group_name 
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = "azureuser"
  network_interface_ids = [ element(var.nics, count.index) ]

  
  #network_interface_ids = [element(azurerm_network_interface.network-interface[*].id, count.index)]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/vm-ssh.pub")
  }
  os_disk {
    caching             = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }

  custom_data = base64encode(local.vm_custom_data)
}
