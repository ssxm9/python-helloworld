provider "google" {
  project = var.project_id
  region  = "us-central1"
}

#terraform { 
#  backend "gcs" {   
#    bucket  = "${var.backend_bucket}"
#    prefix = "${var.env}"
#    project = "<YOUR PROJECT ID>" 
#  }
#}

resource "google_data_catalog_policy_tag" "basic_policy_tag" {
  provider = google-beta
  taxonomy = google_data_catalog_taxonomy.my_taxonomy.id
  display_name = "Low security"
  description = "A policy tag normally associated with low security items"
}

resource "google_data_catalog_taxonomy" "my_taxonomy" {
  provider = google-beta
  region = "us"
  display_name =  "taxonomy_display_name"
  description = "A collection of policy tags"
  activated_policy_types = ["FINE_GRAINED_ACCESS_CONTROL"]
}
