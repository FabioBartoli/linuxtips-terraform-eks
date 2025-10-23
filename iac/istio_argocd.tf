resource "kubectl_manifest" "argocd_gateway" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: argocd-gateway
  namespace: argocd
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - ${var.argocd_domain}
    tls:
      httpsRedirect: true
  - port:
      number: 443
      name: https
      protocol: HTTPS
    hosts:
    - ${var.argocd_domain}
    tls:
      mode: SIMPLE
      credentialName: argocd-tls-secret
YAML

  depends_on = [
    helm_release.istio_ingress,
    helm_release.argocd
  ]
}

# Virtual Service para ArgoCD
resource "kubectl_manifest" "argocd_virtual_service" {
  yaml_body = <<YAML
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: argocd-virtual-service
  namespace: argocd
spec:
  hosts:
  - ${var.argocd_domain}
  gateways:
  - argocd-gateway
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        host: argocd-server
        port:
          number: 80
    timeout: 300s
YAML

  depends_on = [
    kubectl_manifest.argocd_gateway,
    helm_release.argocd
  ]
}
