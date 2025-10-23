resource "helm_release" "alb_ingress_controller" {
  name             = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  namespace        = "kube-system"
  create_namespace = true

  wait    = true
  timeout = 600

  set {
    name  = "clusterName"
    value = aws_eks_cluster.main.name
  }

  set {
    name  = "serviceAccount.create"
    value = true
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_lb_controller.arn
  }

  set {
    name  = "region"
    value = var.aws_region
  }

  set {
    name  = "vpcId"
    value = local.vpc_id
  }

  depends_on = [
    aws_eks_cluster.main,
    aws_eks_node_group.main,
    aws_iam_role.aws_lb_controller,
    aws_iam_policy_attachment.aws_lb_policy,
    aws_iam_openid_connect_provider.eks
  ]
}
