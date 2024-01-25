resource "kubernetes_namespace" "hug" {
  metadata {
    name = "hug"
    labels = {
      name                                 = "hug"
      "pod-security.kubernetes.io/audit"   = "restricted"
      "pod-security.kubernetes.io/warn"    = "restricted"
      "pod-security.kubernetes.io/enforce" = "restricted"
    }
  }
}

resource "kubernetes_service_account" "hug" {
  metadata {
    name      = "hug"
    namespace = kubernetes_namespace.hug.metadata[0].name
    labels = {
      name = "hug"
    }
    annotations = {
      "eks.amazonaws.com/role-arn"               = module.application_iam_role.iam_role_arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}