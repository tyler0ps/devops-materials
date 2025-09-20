data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "hoangthai9217-org"
    workspaces = {
      name = "initiativellm-dev-vpc"
    }
  }
}

