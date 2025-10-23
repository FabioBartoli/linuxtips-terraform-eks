# Data sources para parâmetros SSM
data "aws_ssm_parameter" "vpc_id" {
  name = "/linuxtips/vpc/id"
}

data "aws_ssm_parameter" "public_subnet_1a" {
  name = "/linuxtips/vpc/public-subnet-1a"
}

data "aws_ssm_parameter" "public_subnet_1b" {
  name = "/linuxtips/vpc/public-subnet-1b"
}

data "aws_ssm_parameter" "public_subnet_1c" {
  name = "/linuxtips/vpc/public-subnet-1c"
}

data "aws_ssm_parameter" "private_subnet_1a" {
  name = "/linuxtips/vpc/private-subnet-1a"
}

data "aws_ssm_parameter" "private_subnet_1b" {
  name = "/linuxtips/vpc/private-subnet-1b"
}

data "aws_ssm_parameter" "private_subnet_1c" {
  name = "/linuxtips/vpc/private-subnet-1c"
}


data "aws_eks_cluster" "main" {
  name = aws_eks_cluster.main.name
}

data "aws_eks_cluster_auth" "main" {
  name = aws_eks_cluster.main.name
}
data "tls_certificate" "eks" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]

  depends_on = [aws_eks_cluster.main]
}
