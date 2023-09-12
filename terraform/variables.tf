variable "region" {
  type = string
}
variable "rg-name" {
  type = string
}

#Storage Account vars
variable "sa-name" {
  type = string
}
variable "account_tier" {
  type = string
}
variable "account_replication_type" {
  type = string
}

#Vairtual Nework vars
variable "vnet-name" {
  type = string
}
variable "address_space" {
  type = list(string)
}

variable "address_prefixes" {
  type = list(any)
}

variable "vm-count" {
  type    = number
  default = 2
}
