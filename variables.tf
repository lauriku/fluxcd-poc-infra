variable "project" {
  type = string
  default = "lauriku-gke"
}

variable "region" {
  type = string
  default = "europe-north1"
}

variable "zone" {
  type = string
  default = "europe-north1-a"
}

variable "network" {
  type = string
  default = "gke-vpc"
}

variable "subnetwork" {
  type = string
  default = "gke-subnet"
}

variable "ip_range_pods_name" {
  type = string
  default = "gke-pods"
}
variable "ip_range_services_name" {
  type = string
  default = "gke-services"
}