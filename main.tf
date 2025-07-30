terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

resource "linode_instance" "Matrix-Project" {
  label     = "Matrix"
  region    = "us-east"
  type      = "g6-nanode-1"
  image     = "linode/ubuntu22.04"
  root_pass = var.root_pass
}

variable "linode_token" {}
variable "root_pass" {}