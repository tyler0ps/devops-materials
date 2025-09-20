terraform {
  backend "remote" {
    organization = "hoangthai9217-org"
    workspaces {
      name   = "initiativellm-dev-argocd"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_eks_cluster" "eks" {
  name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = data.terraform_remote_state.eks.outputs.eks_cluster_name
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}
