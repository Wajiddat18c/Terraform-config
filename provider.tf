terraform {
  required_providers {
    citrixadc = {
      source = "citrix/citrixadc"
      version = "1.26.0"
    }
  }
}

provider "citrixadc" {
  endpoint = var.endpoint
  username = var.username
  password = var.password
  do_login   = true
  partition  = var.partitionname
  
}