resource "google_pubsub_topic" "demo" {
  name = "${var.app}-topic-${var.env}-${var.region}"

  labels = {
    app = var.app
  }

  message_retention_duration = "86600s"
}