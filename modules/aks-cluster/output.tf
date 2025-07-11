output "config" {
  description = "The raw Kubernetes config to interact with the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks-cluster.kube_config_raw
  sensitive   = true
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks-cluster.name
}

output "aks_cluster_fqdn" {
  description = "The FQDN of the AKS cluster's API server."
  value       = azurerm_kubernetes_cluster.aks-cluster.fqdn
}

