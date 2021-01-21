#resource "google_bigquery_dataset" "dataset" {
#  dataset_id    = "example_dataset"
#  friendly_name = "test"
#  description   = "This is a test description"
#  location      = "US"

#  labels = {
#    env = "dev"
#  }
#}

resource "google_bigquery_table" "table_bq" {
  #  dataset_id = google_bigquery_dataset.dataset.dataset_id
  dataset_id = var.dataset_id
  table_id   = "bq_table"
  clustering = []
  time_partitioning {
    type  = "DAY"
  }

  labels = {
    env = "dev"
  }

  schema = file("schemas/test.json")

  #  lifecycle {
  #        ignore_changes = [dataset_id,schema]
  #        create_before_destroy = true
  #    }
}

resource "google_bigquery_table" "table_view" {
  dataset_id = var.dataset_id
  table_id   = "view_bq_table"
  view {
    query          = <<EOF
      SELECT 
        fullVisitorId,
        visitId
      FROM `${var.project_id}.${var.dataset_id}.${google_bigquery_table.table_bq.table_id}`
      EOF
    use_legacy_sql = false
  }

  labels = {
    env = "dev"
  }
  #  lifecycle {
  #        ignore_changes = [dataset_id,schema]
  #        create_before_destroy = true
  #    }
}

