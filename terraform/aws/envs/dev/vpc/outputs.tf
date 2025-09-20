output "vpc_id" {
  value = module.eks_vpc.vpc_id
}

output "aws_subnet_private_zone1_id" {
  value = module.eks_vpc.aws_subnet_private_zone1_id
}

output "aws_subnet_private_zone2_id" {
  value = module.eks_vpc.aws_subnet_private_zone2_id
}

output "aws_subnet_public_zone1_id" {
  value = module.eks_vpc.aws_subnet_public_zone1_id
}

output "aws_subnet_public_zone2_id" {
  value = module.eks_vpc.aws_subnet_public_zone2_id
}
