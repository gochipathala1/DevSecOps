output "vnet-name" {
  value = azurerm_virtual_network.vnet.name
}
/*
output "nics" {
  value = toset(values(azurerm_network_interface.network-interface)[*].id)
}


output "nics" {
  value = toset(values(azurerm_network_interface.network-interface)[*].id)
}

output "nics" {
  value = toset([for nic in azurerm_network_interface.network-interface : nic.id])
}
*/
output "nics" {
  value = azurerm_network_interface.network-interface[*].id
}