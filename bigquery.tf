locals {
  dataset_id = "${var.dataset_id}_${var.env}_${var.region}"
}

module "bigquery" {
  source                     = "terraform-google-modules/bigquery/google"
  dataset_id                 = replace(local.dataset_id, "-", "_")
  dataset_name               = replace(local.dataset_id, "-", "_")
  description                = "some description"
  project_id                 = var.project_id
  location                   = var.region
  delete_contents_on_destroy = var.delete_contents_on_destroy
  tables = [
    {
      table_id           = "demo",
      schema             = file("sample_bq_schema.json"),
      time_partitioning  = null,
      range_partitioning = null,
      expiration_time    = 2524604400000, # 2050/01/01
      clustering         = [],
      labels = {
        app      = var.app,
        env      = var.env,
        billable = "true"
        owner    = "tyorikan"
      },
    }
  ]
}
