module "eks_vpc" {
  source = "../../../modules/vpc"

  enable_dns_hostnames = true
  enable_dns_support   = true
  env                  = var.env

  availability_zone1 = "ap-southeast-1a"
  availability_zone2 = "ap-southeast-1b"

  eks_cluster_name = var.eks_cluster_name

}
