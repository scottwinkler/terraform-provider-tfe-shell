#make payload
/bin/cat <<EOF >payload.json
  {
    "data": {
      "type": "organizations",
      "attributes": {
        "name": "${NAME}",
        "email": "${EMAIL}"
      }
    }
  }
EOF
output=$(curl \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data @payload.json \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/organizations)
  sleep 5
  echo "created"
