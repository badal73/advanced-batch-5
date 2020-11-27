resource "kubernetes_service" "kul_service" {
  metadata {
    name = kubernetes_deployment.kul_deploy.metadata.0.name
    namespace = kubernetes_namespace.kul_ns.metadata.0.name
  }
  spec {
    selector = {
        client = kubernetes_deployment.kul_deploy.spec[0].template[0].metadata.0.labels.client
    }
    port {
      port = 80
    }
    type = "NodePort"
  }
}