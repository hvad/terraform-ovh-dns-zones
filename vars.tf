variable "ovh_endpoint" {
  description = "The OVH API endpoint"
  type        = string
  default     = "ovh-eu"
}

variable "ovh_application_key" {
  description = "OVH Application Key"
  type        = string
  sensitive   = true
}

variable "ovh_application_secret" {
  description = "OVH Application Secret"
  type        = string
  sensitive   = true
}

variable "ovh_consumer_key" {
  description = "OVH Consumer Key"
  type        = string
  sensitive   = true
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
