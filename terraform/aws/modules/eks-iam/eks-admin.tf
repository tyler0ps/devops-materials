data "aws_caller_identity" "current" {}

resource "aws_iam_role" "eks_admin" {
  name = "${var.eks_cluster_name}-eks-admin"
  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = ["sts:AssumeRole"],
        "Principal" = {
          "AWS" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "eks_admin" {
  name = "${var.eks_cluster_name}-AmazonEKSAdminPolicy"
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect"   = "Allow",
        "Action"   = ["eks:*"],
        "Resource" = "*"
      },
      {
        "Effect"   = "Allow",
        "Action"   = ["iam:PassRole"],
        "Resource" = "*",
        "Condition" = {
          "StringEquals" = {
            "iam:PassedToService" = "eks.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_admin" {
  role       = aws_iam_role.eks_admin.name
  policy_arn = aws_iam_policy.eks_admin.arn
}

resource "aws_iam_user" "eks_admin" {
  name = "${var.eks_cluster_name}-eks-admin"
}

resource "aws_iam_policy" "eks_assume_admin" {
  name = "${var.eks_cluster_name}-AmazonEKSAssumeAdminPolicy"
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect"   = "Allow",
        "Action"   = ["sts:AssumeRole"],
        "Resource" = "${aws_iam_role.eks_admin.arn}"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "eks_assume_admin" {
  policy_arn = aws_iam_policy.eks_assume_admin.arn
  user       = aws_iam_user.eks_admin.name
}

# Best practice: use IAM roles due to temporary credentials
resource "aws_eks_access_entry" "eks_admin" {
  cluster_name      = var.eks_cluster_name
  principal_arn     = aws_iam_role.eks_admin.arn
  kubernetes_groups = ["my-admin"]
}

# Create access key
resource "aws_iam_access_key" "eks_admin" {
  user = aws_iam_user.eks_admin.name
}
