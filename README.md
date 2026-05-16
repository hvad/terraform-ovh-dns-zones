# Terraform OVH DNS Zones

This Terraform project provides an automated and secure way to manage DNS records 
across multiple domains using the OVHcloud provider. 

Sensitive API credentials are securely encrypted using **sops** and **age**, 
allowing to safely store configurations in source control.

## Features

* **Multi-Domain Support**: Manage multiple DNS zones within a single Terraform configuration.
* **Dynamic Record Creation**: Automatically flattens a custom configuration map to iterate through 
and handle various DNS record types (A, CNAME, TXT, etc.).
* **Enhanced Security**: Credentials are encrypted at rest with SOPS and `age`, 
and unencrypted secrets are automatically prevented from being committed to version control.

## Prerequisites

Before running the project, ensure you have the following tools installed:

* [Terraform](https://developer.hashicorp.com/terraform) (`>= 2.13.1`)
* [SOPS](https://github.com/getsops/sops)
* [age](https://github.com/FiloSottile/age)
* OVHcloud API Credentials (Application Key, Application Secret, and Consumer Key)

---

## Setup & Configuration

### 1. Encryption Keys (`age`)

Generate an encryption key pair using `age` if you don't already have one:

```bash
age-keygen -o key.txt

```

*Note: The `key.txt` file contains private key and is automatically ignored by Git.*

Extract public recipient key from the generated file (it starts with `age1...`).

### 2. Encrypted Secrets (`ovh.json`)

Create a `ovh.json` file chiffré by running the following command:

```bash
sops --age=age1...your_public_key... ovh.json

```

In the editor that opens, structure OVH credentials as follows:

```json
{
  "ovh_application_key": "ovh_app_key",
  "ovh_application_secret": "ovh_app_secret",
  "ovh_consumer_key": "ovh_consumer_key"
}

```

When you save and close the file, SOPS will automatically encrypt the values.

### 3. DNS Zones Configuration (`.tfvars`)

Define your non-sensitive infrastructure configuration and record mappings in a variable file, such as `domain.tfvars`:

```hcl
# OVH API Settings
ovh_endpoint = "ovh-eu"

# DNS Zones and Records Configuration
domains_config = {
  "example.com" = {
    records = [
      { sub = "",    type = "A",   target = "1.2.3.4" },
      { sub = "www", type = "A",   target = "1.2.3.4" },
    ]
  },
  "another-domain.net" = {
    records = [
      { sub = "api", type = "CNAME", target = "lb.example.com." }
    ]
  }
}

```

---

## Usage Instructions

### 1. Environment Setup

Tell to SOPS where to find private key before executing any Terraform commands:

```bash
export SOPS_AGE_KEY_FILE=$(pwd)/key.txt

```

### 2. Initialization

Initialize the workspace to download the required `ovh` and `sops` providers:

```bash
terraform init

```

### 3. Deployment

Run a plan to preview the changes, then apply them to configure your DNS records:

```bash
terraform plan -var-file="domain.tfvars"
terraform apply -var-file="domain.tfvars"

```

---

## Variables Reference

| Name | Description | Type | Default | Sensitive |
| --- | --- | --- | --- | --- |
| `ovh_endpoint` | The OVH API endpoint regional selector | `string` | `ovh-eu` | No |
| `domains_config` | Map of target domains and their respective DNS records | `map(object)` | n/a | No |

---

## Project Architecture

* **`provider.tf`**: Sets up the providers (`ovh`, `sops`) and decodes the chiffré JSON secrets into memory.
* **`main.tf`**: Contains the logic to flatten nested maps and handles the `ovh_domain_zone_record` execution loop.
* **`vars.tf`**: Explicit type declarations for input variables.
* **`ovh.json`**: SOPS-encrypted file protecting your target cloud credentials.
