data "terraform_remote_state" "eks" {
  backend = "remote"
  config = {
    organization = "hoangthai9217-org"
    workspaces = {
      name = "initiativellm-dev-eks"
    }
  }
}

