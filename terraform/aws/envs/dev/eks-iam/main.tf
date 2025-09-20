module "eks_iam" {
  source           = "../../../modules/eks-iam"
  eks_cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}
