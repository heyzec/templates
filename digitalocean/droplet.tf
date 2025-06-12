##### Provider #####
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" { }

data "digitalocean_ssh_key" "terraform" {
  name = "Dell XPS 13"
}

##### Droplet #####
resource "digitalocean_droplet" "default" {
  image = data.digitalocean_image.image.id
  name = "nixie-droplet"
  region = "SGP1"
  size = "s-1vcpu-2gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
}

# Requires image previously uploaded to DigitalOcean
data "digitalocean_image" "image" {
  name = "nixos"
}

output "droplet_ip" {
  value = digitalocean_droplet.default.ipv4_address
}
