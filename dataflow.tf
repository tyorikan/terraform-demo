resource "random_id" "random_suffix" {
  byte_length = 4
}

locals {
  gcs_bucket_name = "${var.region}-tmp-dir-bucket-${random_id.random_suffix.hex}"
}

resource "google_storage_bucket" "tmp_dir_bucket" {
  name          = local.gcs_bucket_name
  location      = var.region
  storage_class = "REGIONAL"
  project       = var.project_id
}

module "dataflow-job" {
  source            = "terraform-google-modules/dataflow/google"
  project_id        = var.project_id
  name              = "pubsub-to-bigquery-example-${var.env}-${var.region}"
  on_delete         = "cancel"
  region            = var.region
  template_gcs_path = "gs://dataflow-templates/latest/PubSub_to_BigQuery"
  temp_gcs_location = google_storage_bucket.tmp_dir_bucket.name
  parameters = {
    inputTopic      = google_pubsub_topic.demo.id
    outputTableSpec = "${var.project_id}:${var.dataset_id}.demo"
  }
}

