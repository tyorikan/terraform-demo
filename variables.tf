variable "env" {}
variable "project_id" {}
variable "region" {
  default = "asia-northeast1"
}
variable "app" {}
variable "dataset_id" {}

// BigQuery
variable "delete_contents_on_destroy" {
  description = "(Optional) If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present."
  type        = bool
  default     = null
}
