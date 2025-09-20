resource "helm_release" "cert_manager" {
  name = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  namespace        = "cert-manager"
  create_namespace = true

  version = var.cert_manager_helm_chart_version

  set = [
    { name = "crds.enabled", value = "true" },
    { name = "crds.keep", value = "true" },
    { name = "config.featureGates.ACMEHTTP01IngressPathTypeExact", value = "false" }
  ]

  depends_on = [helm_release.external_nginx]

}
