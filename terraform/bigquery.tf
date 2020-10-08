resource "google_bigquery_dataset" "dataset" {
  dataset_id    = "example_dataset"
  friendly_name = "test"
  description   = "This is a test description"
  location      = "US"

  labels = {
    env = "dev"
  }
}

resource "google_bigquery_table" "table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "bq_table"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "dev"
  }

  schema = <<EOF
[
  {
    "name": "permalink",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The Permalink"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  }
]
EOF
}
