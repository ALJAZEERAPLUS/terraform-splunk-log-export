terraform {
 backend "gcs" {
   bucket  = "splunk_log_exporter_tfstate"
   prefix  = "terraform/state"
 }
}