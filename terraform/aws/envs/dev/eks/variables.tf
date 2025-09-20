variable "region" {
  default = "ap-southeast-1"
  type    = string
}

variable "eks_cluster_name" {
  default = "oceancloud"
  type    = string
}

variable "env" {
  default = "dev"
  type    = string
}
