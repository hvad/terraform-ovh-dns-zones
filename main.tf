terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "~> 2.13.1"
    }
  }
}

provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = ""
  application_secret = ""
  consumer_key       = ""
}

locals {
  zone = "toulousejudo.com"
}

# 1. Record A (Racine)
resource "ovh_domain_zone_record" "root_a" {
  zone      = local.zone
  subdomain = ""
  fieldtype = "A"
  target    = "51.83.68.73"
}

# 2. Record A (WWW)
resource "ovh_domain_zone_record" "www_a" {
  zone      = local.zone
  subdomain = "www"
  fieldtype = "A"
  target    = "51.83.68.73"
}
