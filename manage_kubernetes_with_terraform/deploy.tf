resource "kubernetes_deployment" "kul_deploy" {
  metadata {
    name = "kuldeploy"
    namespace = kubernetes_namespace.kul_ns.metadata.0.name
    labels = {
      client = "IBM"
    }
  }
  spec {
    replicas = 2
    selector {
        match_labels = {
            client = "IBM"
        }
    }
    template {
      metadata{
          labels = {
              client = "IBM"
          }
      }
      spec {
        container {
            name = "demo"
            image = "httpd:latest"
            image_pull_policy = "Always"
        }
      }
    }
  }
}