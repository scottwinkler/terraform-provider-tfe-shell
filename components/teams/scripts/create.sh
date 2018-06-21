#make payload
/bin/cat <<EOF >payload.json
{
  "data": {
    "type": "teams",
    "attributes": {
      "name": "${NAME}"
    }
  }
}
EOF

apt-get install -y jq > /dev/null

output=$(curl \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data @payload.json \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/organizations/${ORGANIZATION}/teams)
  echo $output | jq '. | {id: .data.id}' -cj
