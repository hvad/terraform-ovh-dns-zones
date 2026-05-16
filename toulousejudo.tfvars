# OVH API Credentials
ovh_endpoint           = "ovh-eu"
ovh_application_key    = "APP_KEY"
ovh_application_secret = "APP_SECRET"
ovh_consumer_key       = "CONSUMER_KEY"

# DNS Zones and Records Configuration
domains_config = {
  "toulousejudo.com" = {
    records = [
      { sub = "",    type = "A",    target = "51.83.68.73" },
      { sub = "www", type = "A",    target = "51.83.68.73" }
    ]
  },
  "toulousejudo.fr" = {
    records = [
      { sub = "",    type = "A",    target = "51.83.68.73" },
      { sub = "www", type = "A",    target = "51.83.68.73" }
    ]
  }
}
