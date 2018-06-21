IN=$(cat)
echo $IN
#apt-get install -y jq > /dev/null
#ID=$(echo $IN | jq '. | .id')

#output=$(curl \
#  --header "Authorization: Bearer ${TOKEN}" \
#  --header "Content-Type: application/vnd.api+json" \
#  --request GET \
#  ${TF_VAR_ATLAS_ADDRESS}/api/v2/teams/${ID})

#echo $output | jq '. | {id: .data.id}' -cj