module "argocd" {
  source = "../../../modules/argocd"

  eks_name = data.aws_eks_cluster.eks.name
}
