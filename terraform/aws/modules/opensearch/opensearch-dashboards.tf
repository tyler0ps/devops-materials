resource "helm_release" "opensearch_dashboards" {
  name             = "opensearch-dashboards"
  repository       = "https://opensearch-project.github.io/helm-charts/"
  chart            = "opensearch-dashboards"
  namespace        = "opensearch"
  version          = "3.0.0"
  create_namespace = true

  atomic          = true
  cleanup_on_fail = true

  values = [
    file("${path.module}/values/opensearch-dashboards.yaml")
  ]

}
