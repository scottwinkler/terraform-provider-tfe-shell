#make payload
/bin/cat <<EOF >payload.json
  {
  "data": {
    "type": "oauth-clients",
    "attributes": {
      "service-provider": "github_enterprise",
      "http-url": "http://githubdev.dco.elmae/",
      "api-url": "http://githubdev.dco.elmae/api/v3",
      "oauth-token-string": "${GITHUB_TOKEN}"
    }
  }
}

EOF
apt-get install -y jq > /dev/null

output=$(curl \
  --header "Authorization: Bearer $TOKEN" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data @payload.json \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/organizations/${ORGANIZATION}/oauth-clients)

sleep 5
echo $output | jq '. | {id: .data.id}' -cj