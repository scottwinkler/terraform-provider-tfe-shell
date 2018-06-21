curl \
  --header "Authorization: Bearer ${TOKEN}" \
  --header "Content-Type: application/vnd.api+json" \
  --request GET \
  ${TF_VAR_ATLAS_ADDRESS}/api/v2/organizations/hashicorp >&2