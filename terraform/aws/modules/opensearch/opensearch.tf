resource "helm_release" "opensearch" {
  name             = "opensearch"
  repository       = "https://opensearch-project.github.io/helm-charts/"
  chart            = "opensearch"
  namespace        = "opensearch"
  version          = "3.0.0"

  create_namespace = true

  cleanup_on_fail = true
  atomic          = true

  values = [file("${path.module}/values/opensearch.yaml")]

  recreate_pods = true

}
