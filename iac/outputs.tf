output "cluster_name" {
  description = "Nome do cluster EKS"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_arn" {
  description = "ARN do cluster EKS"
  value       = aws_eks_cluster.main.arn
}

output "cluster_version" {
  description = "Versão do cluster EKS"
  value       = aws_eks_cluster.main.version
}

output "node_group_name" {
  description = "Nome do node group"
  value       = aws_eks_node_group.main.node_group_name
}

output "node_group_arn" {
  description = "ARN do node group"
  value       = aws_eks_node_group.main.arn
}


