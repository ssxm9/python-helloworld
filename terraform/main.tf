provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-c"
}

terraform { 
  backend "gcs" {   
    bucket  = "terraform-remote-state-test1"
    prefix = "${var.env}"
#    project = "<YOUR PROJECT ID>" 
  }
}
