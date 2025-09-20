provider "aws" {
  region = var.region
}

terraform { 
  backend "remote" {
    organization = "hoangthai9217-org"
    workspaces { 
      name = "initiativellm-dev-vpc"
    } 
  }
}
