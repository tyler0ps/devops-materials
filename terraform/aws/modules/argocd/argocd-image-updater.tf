data "aws_iam_policy_document" "argocd_image_updater" {
  statement {
    effect = "Allow"

    actions = ["sts:TagSession", "sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "argocd_image_updater" {
  name               = "${var.eks_name}-argocd-image-updater"
  assume_role_policy = data.aws_iam_policy_document.argocd_image_updater.json
}

resource "aws_iam_role_policy_attachment" "argocd_image_updater" {
  role       = aws_iam_role.argocd_image_updater.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_pod_identity_association" "argocd_image_updater" {
  cluster_name    = var.eks_name
  namespace       = "argocd"
  service_account = "argocd-image-updater"
  role_arn        = aws_iam_role.argocd_image_updater.arn
}

resource "helm_release" "argocd_image_updater" {

  name = "argocd-image-updater"

  repository       = "https://argoproj.github.io/argo-helm"
  namespace        = "argocd"
  create_namespace = true
  chart            = "argocd-image-updater"
  version          = "0.12.3"

  values = [ file("${path.module}/values/argocd-image-updater.yaml") ]

  depends_on = [helm_release.argocd]
}
