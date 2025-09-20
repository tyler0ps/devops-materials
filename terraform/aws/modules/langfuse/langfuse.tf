resource "helm_release" "langfuse" {

  name       = "langfuse"
  repository = "https://langfuse.github.io/langfuse-k8s"
  chart      = "langfuse"
  version    = "1.3.0"

  namespace        = "langfuse"
  create_namespace = true
  cleanup_on_fail  = true

  values = [file("${path.module}/langfuse-values.yaml")]

  timeout = 300

}
