output "eks_developer_access_key" {
  value     = module.eks_iam.eks_admin_access_key
  sensitive = true
}

output "eks_admin_access_key" {
  value     = module.eks_iam.eks_developer_access_key
  sensitive = true
}
