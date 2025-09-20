resource "aws_iam_user" "eks_developer" {
  name = "${var.eks_cluster_name}-developer"
}

resource "aws_iam_policy" "eks_developer" {
  name = "${var.eks_cluster_name}-AmazonEKSDeveloperPolicy"
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "eks:DescribeCluster",
          "eks:ListCluster"
        ],
        "Resource" = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "eks_developer" {
  user       = aws_iam_user.eks_developer.name
  policy_arn = aws_iam_policy.eks_developer.arn
}

resource "aws_eks_access_entry" "eks_developer" {
  cluster_name      = var.eks_cluster_name
  principal_arn     = aws_iam_user.eks_developer.arn
  kubernetes_groups = ["my-viewer"]
}

# Create access key
resource "aws_iam_access_key" "eks_developer" {
  user = aws_iam_user.eks_developer.name
}
