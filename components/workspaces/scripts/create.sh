#get oauth-token
oauth_token=$(curl \
  --header "Authorization: Bearer $TOKEN" \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/organizations/${ORGANIZATION}/oauth-tokens)
apt-get install -y jq > /dev/null
OAUTH_TOKEN_ID=$(echo $oauth_token | jq .data[0].id)

#make payload
/bin/cat <<EOF >payload.json
{
  "data": {
    "attributes": {
      "name": "${NAME}",
      "terraform-version": "${TERRAFORM_VERSION}",
      "working-directory": "${WORKING_DIRECTORY}",
      "auto-apply": ${AUTO_APPLY},
      "vcs-repo": {
        "identifier": "${VCS_REPO_IDENTIFIER}",
        "oauth-token-id": ${OAUTH_TOKEN_ID},
        "branch": "${VCS_REPO_BRANCH}",
        "ingress-submodules": ${INGRESS_SUBMODULES}
      }
    },
    "type": "workspaces"
  }
}
EOF


#create workspace
output=$(curl \
  --header "Authorization: Bearer $TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data @payload.json \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/organizations/${ORGANIZATION}/workspaces)
  echo $output | jq '. | {id: .data.id}' -cj