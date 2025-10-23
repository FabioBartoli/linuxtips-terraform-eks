variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto para prefixar os recursos"
  type        = string
  default     = "linuxtips-eks"
}

variable "cluster_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "1.28"
}

variable "node_instance_types" {
  description = "Tipos de instância para os nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Número desejado de nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Número máximo de nodes"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Número mínimo de nodes"
  type        = number
  default     = 1
}

variable "istio_version" {
  description = "Versão do Istio"
  type        = string
  default     = "1.19.0"
}

variable "istio_min_replicas" {
  description = "Número mínimo de réplicas do Istio Ingress Gateway"
  type        = number
  default     = 1
}

variable "istio_cpu_threshold" {
  description = "Threshold de CPU para autoscaling do Istio"
  type        = number
  default     = 80
}

variable "nlb_name" {
  description = "Nome do Network Load Balancer"
  type        = string
  default     = "linuxtips-eks-nlb"
}

variable "certificate_arn" {
  description = "ARN do certificado SSL para o NLB"
  type        = string
  default     = "arn:aws:acm:us-east-1:760337697893:certificate/d7fc9463-792e-4f15-9d0d-0dfab0789c02"
}

variable "argocd_domain" {
  description = "Domínio para acesso ao ArgoCD"
  type        = string
  default     = "argocd.fabiobartoli.com.br"
}

variable "common_tags" {
  description = "Tags comuns para todos os recursos"
  type        = map(string)
  default = {
    Project     = "linuxtips-eks"
    Environment = "production"
    ManagedBy   = "terraform"
    Owner       = "fabio"
  }
}

locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  
  public_subnet_ids = [
    data.aws_ssm_parameter.public_subnet_1a.value,
    data.aws_ssm_parameter.public_subnet_1b.value,
    data.aws_ssm_parameter.public_subnet_1c.value
  ]
  
  private_subnet_ids = [
    data.aws_ssm_parameter.private_subnet_1a.value,
    data.aws_ssm_parameter.private_subnet_1b.value,
    data.aws_ssm_parameter.private_subnet_1c.value
  ]
}
