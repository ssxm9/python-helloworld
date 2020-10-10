provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-c"
}

terraform { 
  backend "gcs" {   
    bucket  = "${var.backend_bucket}"
    prefix = "${var.env}"
#    project = "<YOUR PROJECT ID>" 
  }
}
