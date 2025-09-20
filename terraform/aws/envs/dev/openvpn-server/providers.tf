terraform {
  backend "remote" {
    organization = "hoangthai9217-org"
    workspaces {
      name   = "initiativellm-dev-openvpn-server"
    }
  }
}

provider "aws" {
  region = var.region
}
