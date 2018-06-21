IN=$(cat)
echo $IN

#apt-get install -y jq > /dev/null
output="{}"
IFS=';' read -r -a array <<< "$WORKSPACES"
for workspace in "${array[@]}"
do
  ORGANIZATION=$(echo "${workspace}" | cut -d "/" -f 1)
  WORKSPACE_NAME=$(echo "${workspace}" | cut -d "/" -f 2)

IFS=';' read -r -a keys <<< "$VARS_KEYS"
IFS=';' read -r -a values <<< "$VARS_VALUES"
for i in "${!keys[@]}"; do
#make payload

 response=$(curl \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/vnd.api+json" \
  --request POST \
  --data @payload.json \
 ${TF_VAR_ATLAS_ADDRESS}/api/v2/vars)
  id=$(echo "${response}" | jq '.data.id')
  output=$(echo "${output}" | jq ". += {\"${workspace}\":${id}}")
  done
done
echo "${output}" | jq '.' -cj
#apt-get install -y jq > /dev/null
ID=$(echo $IN | jq '. | .id')
ID=$(echo "$ID" | tr -d '"') #strip quotes
echo "curl \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/vnd.api+json" \
  --request DELETE \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/vars/${ID}"

curl \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/vnd.api+json" \
  --request DELETE \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/vars/${ID}
