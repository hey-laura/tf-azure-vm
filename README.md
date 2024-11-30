
# Azure Virtual Machine Module

This Terraform module simplifies the deployment of one or more Azure Virtual Machines (VMs) within a specified Azure location. It supports flexible configurations, dynamic resource creation, and secure SSH authentication.

---

## Features

- Deploys one or more Azure Linux Virtual Machines.
- Dynamically generates resource names based on environment and region.
- Supports flexible VM configurations (e.g., size, admin username).
- Automatically attaches a public IP to each VM.
- Enforces secure SSH key-based authentication.

---

## Requirements

- **Terraform**: v1.5.0 or later
- **AzureRM Provider**: v3.70.0 or later
- **Azure Subscription**: Ensure the subscription ID is set as an environment variable.

---

## Usage

### Example

```
module "azure_vm" {
  source              = "./modules/azure-vm"
  environment         = "dev"
  region              = "eastus"
  vm_count            = 3
  admin_username      = "azureuser"
  vm_size             = "Standard_B1s"
  resource_group_name = "example-rg"
}
```

---

### Inputs

| Name                  | Description                                  | Type   | Default       | Required |
|-----------------------|----------------------------------------------|--------|---------------|----------|
| `location`            | Azure location (e.g., `eastus`, `westus`)   | string | N/A            | Yes      |
| `environment`         | Environment name (e.g., `dev`, `prod`).     | string | N/A            | Yes      |
| `resource_group_name` | Name of the resource group.                 | string | `rg-azure-vm`  | No       |
| `vm_count`            | Number of VMs to create.                    | number | `1`            | No       |
| `admin_username`      | Admin username for the VM.                  | string | `azureuser`    | No       |
| `vm_size`             | Size of the Virtual Machine.                | string | `Standard_B1s` | No       |

---

### Outputs

| Name          | Description                                   |
|---------------|-----------------------------------------------|
| `vm_ids`      | List of IDs of the created Virtual Machines. |
| `vm_names`    | List of names of the created Virtual Machines.|
| `public_ips`  | List of public IP addresses (if enabled).    |

---

## Prerequisites

1. **Set the Azure Subscription ID**:
   The module requires the Azure subscription ID to be set as an environment variable. Run the following command before applying the configuration:
   ```bash
   export ARM_SUBSCRIPTION_ID="your-subscription-id"
   ```

2. **Azure Authentication**:
   Log in using the Azure CLI:
   ```bash
   az login
   ```

---

## License

This module is open-source and available under the MIT License.

---


# Azure Linux VM Sizes with Pricing (East US Region)

For current sizes and pricing visit the [Azure Instances Size documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/overview). Below are a few examples: 

| **VM Series**   | **VM Size**       | **vCPUs** | **Memory (GiB)** | **Price per Hour (USD)** |
|------------------|-------------------|-----------|------------------|--------------------------|
| **B-Series**     | B1s               | 1         | 1                | $0.012                   |
|                  | B2s               | 2         | 4                | $0.049                   |
| **D-Series**     | D2_v5             | 2         | 8                | $0.096                   |
|                  | D4_v5             | 4         | 16               | $0.192                   |
| **E-Series**     | E2s_v5            | 2         | 16               | $0.113                   |
|                  | E4s_v5            | 4         | 32               | $0.226                   |
| **F-Series**     | F2s_v2            | 2         | 4                | $0.085                   |
|                  | F4s_v2            | 4         | 8                | $0.170                   |
| **L-Series**     | L4s               | 4         | 32               | $0.376                   |
|                  | L8s               | 8         | 64               | $0.752                   |
| **M-Series**     | M8ms              | 8         | 218              | $1.872                   |
|                  | M16ms             | 16        | 433              | $3.744                   |

## Key Considerations

- **Pricing Variability**: The prices listed above are indicative for the **East US** region and are subject to change. Prices may vary based on Azure region, subscription type, and other factors. Always check the [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/) for the latest details.

- **Operating System Costs**: These prices apply to Linux VMs. Windows VMs may have additional licensing fees. For detailed Windows VM pricing, see the [Azure Windows VM Pricing](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/).

- **Billing Options**:
  - **Pay-As-You-Go**: Flexible billing based on actual usage, ideal for unpredictable workloads.
  - **Reserved Instances**: Commit to one- or three-year terms for significant discounts, suitable for stable, long-term workloads.
  - **Spot Instances**: Access unused capacity at reduced rates, with the risk of eviction when Azure needs capacity.

- **Additional Costs**: Be aware of extra charges for storage, networking, and other associated resources.

For the most accurate and up-to-date pricing, visit the [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/).


---
For questions or issues, feel free to open a GitHub issue or contact the maintainer.