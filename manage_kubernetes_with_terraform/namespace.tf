resource "kubernetes_namespace" "kul_ns" {
  metadata {
    annotations = {
      name = "example-annotation"
    }

    labels = {
      mylabel = "label-value"
    }

    name = "kulns"
  }
}
