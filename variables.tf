variable "location" {
  type = string
  default = "West Europe"
}

# IPs VNets
variable "iphubvnet" {
  type = string
  default = "10.0.0.0/16"
}

variable "ipspoke1vnet" {
  type = string
  default = "192.168.0.0/24"
}

variable "ipspoke2vnet" {
  type = string
  default = "192.168.1.0/24"
}

# IPs Subnets
variable "ipsubdmz" {
  type = string
  default = "10.0.0.0/24"
}

variable "ipsubsp1" {
  type = string
  default = "192.168.0.0/24"
}