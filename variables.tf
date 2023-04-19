variable "endpoint" {
  type        = string
  description = "Endpoint for subnetip"
}

variable "partitionname" {
  type        = string
  description = "Partition name for the new partition"
}

variable "subnetip" {
  type        = number
  description = "Subnet IP for the new partition"
}
variable "netmask" {
  type        = string
  description = "netmark for the new partition"
}
variable "gateway" {
  type        = string
  description = "gateway for the new partition"
}

