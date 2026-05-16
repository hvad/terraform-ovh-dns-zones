variable "ovh_endpoint" {
  description = "The OVH API endpoint"
  type        = string
  default     = "ovh-eu"
}

variable "domains_config" {
  description = "Configuration map for multiple domains and their DNS records"
  type = map(object({
    records = list(object({
      sub    = string
      type   = string
      target = string
    }))
  }))
}
