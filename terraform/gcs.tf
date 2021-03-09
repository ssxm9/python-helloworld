resource "google_storage_bucket" "my_bucket" {
  name     = "${var.project_id}-test-334"
  location = "US"
  labels   = {
    atlas: "tf_backend-${var.env}" 
  }
}
