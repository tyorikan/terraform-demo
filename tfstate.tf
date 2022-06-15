// TODO: Generate tfstate file by script
// Change bucket name, and set prefix if needed
terraform {
  backend "gcs" {
    bucket = "anthosday-tfstate"
    prefix = "dev/demo"
  }
}
