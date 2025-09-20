variable "env" {}

variable "vpc_cidir" {
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  default = false
}

variable "enable_dns_support" {
  default = false
}

variable "availability_zone1" {}

variable "availability_zone2" {}

variable "eks_cluster_name" {}