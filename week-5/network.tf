resource "kubernetes_network_policy_v1" "db" {
  metadata {
    name = "db-allow-web"
  }

  spec {
    pod_selector {
      match_labels = {
        app = "db"
      }
    }

    policy_types = ["Ingress"]

    ingress {
      from {
        pod_selector {
          match_labels = {
            app = "web"
          }
        }
      }

      ports {
        port     = "5432"
        protocol = "TCP"
      }
    }
  }
}
