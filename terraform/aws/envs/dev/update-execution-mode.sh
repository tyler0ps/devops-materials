#!/bin/zsh
export TFC_TOKEN=

curl \
  --header "Authorization: Bearer $TFC_TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request PATCH \
  --data '{
    "data": {
      "type": "workspaces",
      "attributes": {
        "execution-mode": "local"
      }
    }
  }' \
  https://app.terraform.io/api/v2/organizations/hoangthai9217-org/workspaces/initiativellm-dev-eks
