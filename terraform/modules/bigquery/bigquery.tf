#resource "google_bigquery_dataset" "dataset" {
#  dataset_id    = "example_dataset"
#  friendly_name = "test"
#  description   = "This is a test description"
#  location      = "US"

#  labels = {
#    env = "dev"
#  }
#}

module "policy_tag" {
  source = "../data_policy_tag"
}

resource "google_bigquery_table" "table_bq" {
  #  dataset_id = google_bigquery_dataset.dataset.dataset_id
  dataset_id = var.dataset_id
  table_id   = "bq_table"
  clustering = []
  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "dev"
  }

#  schema = file("schemas/test.json")
  schema = <<EOF
    [
      {
        "description": "Full visitor ID",
        "mode": "NULLABLE",
        "name": "fullVisitorId",
        "type": "STRING",
        "policyTags": {
          "names": ["${module.policy_tag.google_data_catalog_policy_tag_high}"]
        }
      },
      {
        "description": "Visit number",
        "mode": "NULLABLE",
        "name": "visitNumber",
        "type": "INTEGER",
        "policyTags": {
          "names": ["${module.policy_tag.google_data_catalog_policy_tag_low}"]
        }
      },
      {
        "description": "Visit ID",
        "mode": "NULLABLE",
        "name": "visitId",
        "type": "INTEGER"
      },
      {
        "description": "Visit Start Time",
        "mode": "NULLABLE",
        "name": "visitStartTime",
        "type": "INTEGER"
      },
      {
        "description": "Full Date of Visit",
        "mode": "NULLABLE",
        "name": "fullDate",
        "type": "DATE"
      }
   ]
EOF    

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

