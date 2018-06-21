#!/usr/bin/env bash
#apt-get install -y jq > /dev/null
IFS=';' read -r -a array <<< "$WORKSPACES"
for workspace in "${array[@]}"
do
  ORGANIZATION=$(echo "${workspace}" | cut -d "/" -f 1)
  WORKSPACE_NAME=$(echo "${workspace}" | cut -d "/" -f 2)

IFS=';' read -r -a keys <<< "$VARS_KEYS"
IFS=';' read -r -a values <<< "$VARS_VALUES"
for i in "${!keys[@]}"; do
#make payload
/bin/cat <<EOF >payload.json
{
    "data": {
        "type": "vars",
        "attributes": {
            "key": "${keys[$i]}",
            "value": "${values[$i]}",
            "category": "terraform",
            "hcl": false,
            "sensitive": false
        }
    },
    "filter": {
        "organization": {
            "name": "${ORGANIZATION}"
        },
        "workspace": {
            "name": "${WORKSPACE_NAME}"
        }
    }
}
EOF

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
echo $ARRAY
output=$( IFS=, ; echo "${ARRAY[*]}"
echo $output
#echo "bar=$( IFS=, ; echo "${output[*]}"