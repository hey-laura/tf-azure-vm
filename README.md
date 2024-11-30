
# Azure Virtual Machine Module

This Terraform module simplifies the deployment of one or more Azure Virtual Machines (VMs) within a specified Azure location. It supports flexible configurations, dynamic resource creation, and secure SSH authentication.

## Features

- Deploys one or more Azure Linux Virtual Machines.
- Dynamically generates resource names based on environment and region.
- Supports flexible VM configurations (e.g., size, admin username).
- Automatically attaches a public IP to each VM.
- Enforces secure SSH key-based authentication.

## Requirements

- **Terraform**: v1.5.0 or later
- **Azure CLI**: v2.67.0 or later
- **AzureRM Provider**: v3.70.0 or later
- **Azure Subscription**: Ensure the subscription ID is set as an environment variable.

## Usage

```
tree
├── README.md
└── terraform
    ├── modules
    │   └── azure-vm
    │       ├── az-vm.tf
    │       ├── outputs.tf
    │       └── variables.tf
    └── sites
        └── eastus
            ├── main.tf
            ├── outputs.tf
            └── versions.tf

6 directories, 7 files
```

### 1. Configure the Environment
Set the Azure Subscription ID: Terraform requires the Azure subscription ID to authenticate. Export it as an environment variable:

```bash
export ARM_SUBSCRIPTION_ID="your-subscription-id"
```
Log in using the Azure CLI:
   ```bash
   az login
   ```

### 2. Initialize Terraform
Navigate to the site-specific directory (e.g., eastus):

```bash
cd terraform/sites/eastus
terraform init
```

### 3. Plan the Deployment
Generate an execution plan to preview the resources Terraform will create:

```bash
terraform plan
```

### 4. Apply the Configuration
Deploy the infrastructure:

```bash
terraform apply
```

Terraform will prompt for confirmation before creating the resources. Type **yes** to proceed.

### 5. Verify the Deployment
Get Outputs: After applying, view the outputs (e.g., VM names, public IPs):

```bash
terraform output
```
SSH into the VM: Use the private SSH key to connect to the VM:

```bash
ssh -i id_rsa azureuser@<public-ip>
```


### Instance Example

```
module "azure_vm" {
  source              = "./modules/azure-vm"
  environment         = "dev"
  location            = "eastus"
  vm_count            = 2
  admin_username      = "azureuser"
  vm_size             = "Standard_B1s"
  resource_group_name = "example-rg"
}
```

### Outputs

| Name          | Description                                   |
|---------------|-----------------------------------------------|
| `vm_ids`      | List of IDs of the created Virtual Machines. |
| `vm_names`    | List of names of the created Virtual Machines.|
| `public_ips`  | List of public IP addresses.    |

---

## Azure Linux VM Sizes with Pricing (East US Region)

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
---

## License

This module is open-source and available under the MIT License.

---

For questions or issues, feel free to open a GitHub issue or contact the maintainer.