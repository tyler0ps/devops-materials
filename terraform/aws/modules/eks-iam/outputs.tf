output "eks_developer_access_key" {
  value     = "ID: ${aws_iam_access_key.eks_developer.id} KEY: ${aws_iam_access_key.eks_developer.secret}"
  sensitive = true
}

output "eks_admin_access_key" {
  value     = "ID: ${aws_iam_access_key.eks_admin.id} KEY: ${aws_iam_access_key.eks_admin.secret}"
  sensitive = true
}
