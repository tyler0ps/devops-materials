provider "aws" {
  region = var.region
}

terraform {
  backend "remote" {
    organization = "hoangthai9217-org"
    workspaces {
      name   = "initiativellm-dev-eks"
    }
  }
}

data "aws_eks_cluster" "eks" {
  name       = module.eks_cluster.aws_eks_cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name       = module.eks_cluster.aws_eks_cluster_name
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}
