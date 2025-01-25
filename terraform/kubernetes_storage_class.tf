# resource "kubernetes_storage_class" "gold" {
#   metadata {
#     name = "gold"
#   }
#   storage_provisioner    = "kubernetes.io/gce-pd"
#   volume_binding_mode    = "Immediate"
#   allow_volume_expansion = true
#   reclaim_policy         = "Delete"
#   parameters = {
#     type = "pd-standard"
#     fsType : "ext4"
#     encrypted : "none"
#   }
# }
