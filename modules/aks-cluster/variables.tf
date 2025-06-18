variable "location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the existing resource group to deploy the AKS cluster into."
  type        = string
}

variable "service_principal_name" {
  description = "The display name of the Azure Service Principal to be used by AKS."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key content for AKS Linux profile"
  type        = string
}


variable "client_id" {
  description = "The Application (client) ID of the Azure Service Principal."
  type        = string
}

variable "client_secret" {
  description = "The client secret (password) for the Azure Service Principal."
  type        = string
  sensitive   = true
}
