
# 📄 AKS Cluster Infrastructure Deployment on Azure with Terraform & Azure DevOps CI/CD


This project provisions an **Azure Kubernetes Service (AKS)** cluster using **Terraform** and automates infrastructure deployment with **Azure DevOps CI/CD pipelines**. It creates all necessary Azure resources (Resource Group, AKS Cluster, Service Principal, Key Vault, Role Assignments) in a modular, secure, and fully automated way.

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


Login to Azure CLI

```console
az login
```

Set the subscription (if you have multiple)

```console
az account set --subscription "your-subscription-id"
```

Verify your current subscription

```console
az account show
```


## 🚀 Deployment Instructions (Manual)

### 1. Clone the Repository

```console
git clone https://github.com/TanmayaChoudhury/3tierapp-cicd-infra.git
cd 3tierapp-cicd-infra
```
### 2. Configure Variables

Edit the terraform.tfvars file with your specific values:

Example terraform.tfvars

```hcl
rgname                  = "aks-rg"
location                = "canadacentral"
service_principal_name  = "aks-sp"
keyvault_name           = "tanmaya-portfolio-aks-kv"
SUB_ID                  = "85f9051c-3d5f-4da3-bc26-34686532"
```

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

---

## 🤖 CI/CD with Azure DevOps

This project integrates with **Azure DevOps Pipelines** for automated infrastructure provisioning and teardown. The following YAML pipeline files are included:

- `Create-infra.yml` — Deploys all infrastructure using Terraform (run on PR merge or manually)
- `Destroy-infra.yml` — Destroys all provisioned resources (run manually for cleanup)

### Setting up Azure DevOps Pipelines

1. **Import the repository** into your Azure DevOps project.
2. **Create two pipelines**:
   - One using `Create-infra.yml` for provisioning
   - One using `Destroy-infra.yml` for teardown
3. **Configure pipeline variables/secrets** for Azure credentials, subscription ID, and any sensitive values (use Azure DevOps Library or variable groups).
4. **Run the pipelines** as needed:
   - On code changes/PR merge: triggers `Create-infra.yml`
   - For cleanup: run `Destroy-infra.yml` manually

> **Tip:** Review and update the YAML files to match your Azure DevOps environment and naming conventions.

---

## ⚠️ Common Issues & Solutions

### ⚠️ Common Issues & Solutions

| **Issue**                                    | **Root Cause**                                                              | **Solution**                                                                                                   |
| :------------------------------------------- | :-------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------- |
| **403 Forbidden on Key Vault Secret Access** | Terraform Service Principal (SPN) lacked permissions on the Azure Key Vault | Assign **Key Vault Secrets Officer** role to both **Terraform SPN** and the created SPN at the Key Vault scope |
| **403 on Role Assignment Creation**          | Terraform SPN didn't have permission to assign roles at subscription level  | Assign **User Access Administrator** role to the Terraform SPN at **subscription scope**                       |

## 🔧 Configuration Options

### Key Variables

| **Variable**             | **Description**                  | **Default**          | **Required** |
| :----------------------- | :------------------------------- | :------------------- | :----------- |
| `rgname`                 | Name of the Azure Resource Group | `-`                  | ✅ Yes        |
| `location`               | Azure region                     | `-`                  | ✅ Yes        |
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

- **Resource Group Name**
- **Service Principal Client ID**
- **Service Principal Client SECRET(Sensitive)**
- **Kubeconfig File**:  
  A local file named `kubeconfig` will be generated in our project directory, containing the AKS cluster connection configuration.  
  👉 We can use it to interact with your AKS cluster:
  ```bash
  kubectl --kubeconfig=./kubeconfig get nodes
  ```

  📌 **Note:** This file is generated locally during `terraform apply` and should be secured and/or added to `.gitignore`.


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


---

### 📌 Author
**Tanmaya Choudhury**
Project: 3tierapp-cicd-infra
GitHub: [TanmayaChoudhury/3tierapp-cicd-infra](https://github.com/TanmayaChoudhury/3tierapp-cicd-infra)
