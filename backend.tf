terraform {
  backend "gcs" {
    bucket  = "lauriku-terraform-state"
    prefix  = "dev/"
  }
}