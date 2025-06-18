# 📄 AKS Cluster Infrastructure Deployment on Azure using Terraform

This project provisions an **Azure Kubernetes Service (AKS)** cluster using **Terraform**. It automates the creation of necessary infrastructure components like the **Resource Group**, **AKS Cluster**, **Service Principal**, **Key Vault**, and **Role Assignments** — ensuring a fully automated and secure deployment process.

## 🏗️ Infrastructure Components

This Terraform configuration creates the following Azure resources:

- **Resource Group** — Container for all resources
- **AKS Cluster** — Managed Kubernetes service
- **Service Principal** — Authentication for AKS cluster
- **Key Vault** — Secure storage for secrets and certificates
- **Virtual Network** — Network infrastructure for the cluster
- **Role Assignments** — Proper permissions and access control

---

## ✅ Prerequisites

Before you begin, ensure you have the following:

- Azure Subscription with appropriate permissions
- Terraform CLI (version 1.0+) installed locally
- Azure CLI installed and authenticated
- Account with **Owner** or **User Access Administrator** role on the target subscription

### 🔐 Authentication Setup


#Login to Azure CLI

```console
az login
```

#Set the subscription (if you have multiple)

```console
az account set --subscription "your-subscription-id"
```

#Verify your current subscription

```console
az account show
```

## 🚀 Deployment Instructions

### 1. Clone the Repository

```console
git clone https://github.com/TanmayaChoudhury/azure-aks-cluster-terraform.git
```

```console
cd azure-aks-cluster-terraform
```
### 2. Configure Variables

Edit the terraform.tfvars file with your specific values:

#Example terraform.tfvars

resource_group_name = "rg-aks-prod"
location           = "East US"
cluster_name       = "aks-cluster-prod"
node_count         = 3
vm_size           = "Standard_DS2_v2"

### 3. Initialize Terraform

```console
terraform init
```

### 4. Plan the Deployment

```console
terraform plan
```

Review the planned changes carefully before proceeding.

### 5. Apply the Configuration

```console
terraform apply
```
## ⚠️ Common Issues & Solutions

| **Issue**                                    | **Root Cause**                                                              | **Solution**                                                                                                   |
| :------------------------------------------- | :-------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------- |
| **403 Forbidden on Key Vault Secret Access** | Terraform Service Principal (SPN) lacked permissions on the Azure Key Vault | Assign **Key Vault Secrets Officer** role to both **Terraform SPN** and the created SPN at the Key Vault scope |
| **403 on Role Assignment Creation**          | Terraform SPN didn't have permission to assign roles at subscription level  | Assign **User Access Administrator** role to the Terraform SPN at **subscription scope**                       |
| **Resource Group Already Exists**            | Trying to create a resource group that already exists                       | Either use a different name or import the existing resource group                                              |
| **Insufficient Quota**                       | VM size or region doesn't have enough quota                                 | Choose a different VM size or request a quota increase                                                         |

## 🔧 Configuration Options

### Key Variables

| **Variable**             | **Description**                  | **Default**          | **Required** |
| :----------------------- | :------------------------------- | :------------------- | :----------- |
| `rgname`                 | Name of the Azure Resource Group | `-`                  | ✅ Yes        |
| `location`               | Azure region                     | `East US` (optional) | ❌ No         |
| `service_principal_name` | Name for the Service Principal   | `-`                  | ✅ Yes        |
| `keyvault_name`          | Name for the Azure Key Vault     | `-`                  | ✅ Yes        |
| `SUB_ID`                 | Azure Subscription ID            | `-`                  | ✅ Yes        |



### Module Configuration

The project uses a modular structure for better organization:

**keyvault/** - Azure Key Vault configuration
**service-principal/** - Service Principal creation and management
**aks-cluster/** - Virtual Network and subnet configuration

### 📊 Outputs

After successful deployment, the following outputs will be available:

**Resource Group Name**
**Service Principal Client ID**
**Service Principal Client SECRET(Sensitive)**


### 🧹 Cleanup

To destroy the infrastructure:

```console
terraform destroy
```

⚠️ Warning: This will permanently delete all resources created by this Terraform configuration.


### 📋 Best Practices

**State Management:** Store Terraform state in Azure Storage Account for team collaboration
**Secrets:** Never commit sensitive values to version control
**Modules:** Use modules for reusable components
**Versioning:** Pin provider and module versions for consistency
**Validation:** Always run terraform plan before applying changes

### 📙 Additional Notes

Avoid committing .tfstate files or sensitive configurations to version control
The project uses a modular Terraform structure for better scalability and reuse
Regularly update Terraform providers and modules for security patches

### 📌 Author
**Tanmaya Choudhury**
🔗 GitHub Profile