variable "vpc_id" {
  type        = string
  description = "The VPC That OpenVPN server will be installed into."
}

variable "public_subnet_id" {
  type = string
  description = "value of the public subnet ID where OpenVPN server will be installed."
}