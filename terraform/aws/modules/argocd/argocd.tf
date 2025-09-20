resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "8.1.2"

  values = [file("${path.module}/values/argocd.yaml")]

#   depends_on = [helm_release.cert_manager]

}
