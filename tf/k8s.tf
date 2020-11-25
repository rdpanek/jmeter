resource "digitalocean_kubernetes_cluster" "tab" {

  name     = "perf-stack"
  region   = "fra1"
  version = "1.19.3-do.2"
  node_pool {
    name       = "perf-stack"
    size       = "s-4vcpu-8gb"
    node_count = 6
  }
  tags    = ["tab", "performance", "jmeter"]

  provisioner "local-exec" {
    command = "doctl kubernetes cluster kubeconfig save perf-stack"
  }
}
