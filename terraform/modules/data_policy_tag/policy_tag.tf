resource "google_data_catalog_policy_tag" "basic_policy_tag_high" {
  provider     = google-beta
  taxonomy     = google_data_catalog_taxonomy.my_taxonomy.id
  display_name = "High"
  description  = "A policy tag for high security items"
}

resource "google_data_catalog_policy_tag" "basic_policy_tag_low" {
  provider     = google-beta
  taxonomy     = google_data_catalog_taxonomy.my_taxonomy.id
  display_name = "Low"
  description  = "A policy tag for low security items"
}

resource "google_data_catalog_taxonomy" "my_taxonomy" {
  provider               = google-beta
  region                 = "us"
  display_name           = "txt_tx123"
  description            = "A collection of policy tags"
  activated_policy_types = ["FINE_GRAINED_ACCESS_CONTROL"]
}

resource "google_data_catalog_policy_tag_iam_member" "member" {
  provider   = google-beta
  policy_tag = google_data_catalog_policy_tag.basic_policy_tag_high.name
  role       = "roles/datacatalog.categoryFineGrainedReader"
  member     = "user:satyabratasiliconindia@gmail.com"
}

output "google_data_catalog_policy_tag_high" {
  value = google_data_catalog_policy_tag.basic_policy_tag_high.id
}

output "google_data_catalog_policy_tag_low" {
  value = google_data_catalog_policy_tag.basic_policy_tag_low.id
}

