terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "~> 2.13.1"
    }
    sops = {
      source  = "carlpett/sops"
      version = "~> 1.0"
    }
  }
}

data "sops_file" "ovh_secrets" {
  source_file = "ovh.json"
}

provider "ovh" {
  endpoint           = var.ovh_endpoint
  application_key    = data.sops_file.ovh_secrets.data["ovh_application_key"]
  application_secret = data.sops_file.ovh_secrets.data["ovh_application_secret"]
  consumer_key       = data.sops_file.ovh_secrets.data["ovh_consumer_key"]
}
