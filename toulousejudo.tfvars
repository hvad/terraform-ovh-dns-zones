# OVH
ovh_endpoint           = "ovh-eu"

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
