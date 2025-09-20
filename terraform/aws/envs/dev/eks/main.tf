module "eks_cluster" {
  source = "../../../modules/eks"

  region = var.region

  env              = var.env
  eks_cluster_name = var.eks_cluster_name
  eks_version      = "1.32"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  subnet_ids = [
    data.terraform_remote_state.vpc.outputs.aws_subnet_private_zone1_id,
    data.terraform_remote_state.vpc.outputs.aws_subnet_private_zone2_id,
  ]

  node_group_name = "general"
  instance_types  = ["t4g.medium"]
  ami_type        = "AL2023_ARM_64_STANDARD"

}

# tyleradmin
# resource "aws_eks_access_entry" "tylerawsadmin" {
#   cluster_name  = module.eks_cluster.aws_eks_cluster_name
#   principal_arn = "arn:aws:iam::535002848241:user/tyleraws-admin"
# }

# resource "aws_eks_access_policy_association" "example" {
#   cluster_name  = module.eks_cluster.aws_eks_cluster_name
#   policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
#   principal_arn = "arn:aws:iam::535002848241:user/tyleraws-admin"

#   access_scope {
#     type = "cluster"
#   }
# }
