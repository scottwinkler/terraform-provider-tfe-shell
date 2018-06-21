curl \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/vnd.api+json" \
  --request DELETE \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/organizations/${NAME} >&2