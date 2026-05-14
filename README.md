# Terraform OVH DNS Zones

This Terraform project provides a automated way to manage DNS records 
across multiple domains using the OVHcloud provider.

## Features

* **Multi-Domain Support**: Manage multiple DNS zones within a single Terraform configuration.
* **Dynamic Record Creation**: Uses a flattened configuration map to iterate through and create various DNS record types (A, CNAME, TXT, etc.).
* **Security Focused**: Sensitive API credentials are marked as sensitive to prevent exposure in logs or console output.

## Prerequisites

* [Terraform](https://developer.hashicorp.com/terraform) (version compatible with provider `>= 2.13.1`).
* OVHcloud API Credentials (Application Key, Application Secret, and Consumer Key).

----

## Usage

### 1. Configuration

Define your domains and records in a `terraform.tfvars` file (Note: this file is ignored by git for security).

```hcl
ovh_application_key    = "your_app_key"
ovh_application_secret = "your_app_secret"
ovh_consumer_key       = "your_consumer_key"

domains_config = {
  "example.com" = {
    records = [
      { sub = "www", type = "A", target = "1.2.3.4" },
      { sub = "",    type = "TXT", target = "v=spf1 include:mx.ovh.com ~all" }
    ]
  },
  "another-domain.net" = {
    records = [
      { sub = "api", type = "CNAME", target = "lb.example.com." }
    ]
  }
}

```

### 2. Initialization

```bash
terraform init

```

### 3. Deployment

```bash
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"

```

----

## Variables

| Name | Description | Type | Default | Sensitive |
| --- | --- | --- | --- | --- |
| `ovh_endpoint` | The OVH API endpoint | `string` | `ovh-eu` | No |
| `ovh_application_key` | OVH Application Key | `string` | n/a | **Yes** |
| `ovh_application_secret` | OVH Application Secret | `string` | n/a | **Yes** |
| `ovh_consumer_key` | OVH Consumer Key | `string` | n/a | **Yes** |
| `domains_config` | Map of domains and their records | `map(object)` | n/a | No |

----

## Project Structure

* `main.tf`: Contains the provider configuration, local logic for flattening record maps, and the `ovh_domain_zone_record` resource.
* `vars.tf`: Definitions for all input variables.
