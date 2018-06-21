IN=$(cat)
apt-get install -y jq > /dev/null
ID=$(echo $IN | jq '. | .id')
ID=$(echo "$ID" | tr -d '"') #strip quotes
echo "curl \
  --header \"Authorization: Bearer ${TOKEN}\" \
  --header \"Content-Type: application/vnd.api+json\" \
  --request DELETE \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/teams/${ID}"

curl \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/vnd.api+json" \
  --request DELETE \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/teams/${ID}

