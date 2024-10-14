# -------------------------------------------------- #
# Google Cloud CDN Configuration for Cloud Run      #
# -------------------------------------------------- #

resource "google_compute_backend_service" "hydroserver_backend" {
  name                  = "hydroserver-backend-${var.instance}"
  load_balancing_scheme = "EXTERNAL"
  protocol              = "HTTP"

  backend {
    group = google_compute_region_network_endpoint_group.hydroserver_neg.id
  }

  enable_cdn = true

  cdn_policy {
    cache_mode        = "CACHE_ALL_STATIC"
    default_ttl      = 3600
    max_ttl          = 86400
    cache_key_policy {
      include_host          = true
      include_protocol      = true
    }
  }
}
