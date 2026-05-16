locals {
  # Flatten the nested domain structure into a single map for the resource loop
  # The key is constructed as "domain_subdomain_type" to ensure uniqueness
  flattened_records = merge([
    for domain, config in var.domains_config : {
      for record in config.records : 
        "${domain}_${record.sub == "" ? "@" : record.sub}_${record.type}" => {
          zone      = domain
          subdomain = record.sub
          fieldtype = record.type
          target    = record.target
        }
    }
  ]...)
}

# Resource to create DNS records for all domains defined in tfvars
resource "ovh_domain_zone_record" "multi_domain_records" {
  for_each = local.flattened_records

  zone      = each.value.zone
  subdomain = each.value.subdomain
  fieldtype = each.value.fieldtype
  target    = each.value.target
}
