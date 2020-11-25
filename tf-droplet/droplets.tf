provider "digitalocean" {}

variable "vm_count" {
  default = 2
}

data "digitalocean_image" "canarytrace" {
  name = "canarytrace-virtual"
}

resource "digitalocean_droplet" "canarytrace" {
  count = var.vm_count

  image    = data.digitalocean_image.canarytrace.id
  name     = "canarytrace${count.index}"
  region   = "fra1"
  size     = "s-4vcpu-8gb"
  monitoring = true

}

output "ip" {
  value = [
    for instance in digitalocean_droplet.canarytrace: instance.ipv4_address
  ]
}
