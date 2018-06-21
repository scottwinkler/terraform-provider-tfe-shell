if ! git --version >/dev/null; then
    apt-get install -y git-core >/dev/null
fi
git clone https://github.com/hashicorp/tfe-cli.git

IFS=';' read -r -a array <<< "$WORKSPACES"
for workspace in "${array[@]}"
do
  ORGANIZATION=$(echo $workspace | cut -d "/" -f 1)
  NAME=$(echo $workspace | cut -d "/" -f 2)

echo "got here1"
  #update vars
  IFS=';' read -r -a keys <<< "$VARS_KEYS"
  IFS=';' read -r -a values <<< "$VARS_VALUES"
  for i in "${!keys[@]}"; do
    echo "key ${keys[$i]}"
    echo "value ${values[$i]}"
    ./tfe-cli/bin/tfe pushvars -name $ORGANIZATION/$NAME  -var "${keys[$i]}=${values[$i]}" -overwrite ${keys[$i]} -tfe-address $TF_VAR_ATLAS_ADDRESS -token $TOKEN
  done
echo "got here2"
  #update sensitive vars
  IFS=';' read -r -a keys <<< "$SENSITIVE_VARS_KEYS"
  IFS=';' read -r -a values <<< "$SENSITIVE_VARS_VALUES"
  for i in "${!keys[@]}"; do
    echo "key ${keys[$i]}"
    echo "value ${values[$i]}"
    ./tfe-cli/bin/tfe pushvars -name $ORGANIZATION/$NAME  -svar "${keys[$i]}=${values[$i]}" -overwrite ${keys[$i]} -tfe-address $TF_VAR_ATLAS_ADDRESS -token $TOKEN
  done

  #update environment vars
  IFS=';' read -r -a keys <<< "$ENVIRONMENT_VARS_KEYS"
  IFS=';' read -r -a values <<< "$ENVIRONMENT_VARS_VALUES"
  for i in "${!keys[@]}"; do
    echo "key ${keys[$i]}"
    echo "value ${values[$i]}"
    ./tfe-cli/bin/tfe pushvars -name $ORGANIZATION/$NAME  -env-var "${keys[$i]}=${values[$i]}" -overwrite ${keys[$i]} -tfe-address $TF_VAR_ATLAS_ADDRESS -token $TOKEN
  done

  #update sensitive environment vars
  IFS=';' read -r -a keys <<< "$SENSITIVE_ENVIRONMENT_VARS_KEYS"
  IFS=';' read -r -a values <<< "$SENSITIVE_ENVIRONMENT_VARS_VALUES"
  for i in "${!keys[@]}"; do
    echo "key ${keys[$i]}"
    echo "value ${values[$i]}"
    ./tfe-cli/bin/tfe pushvars -name $ORGANIZATION/$NAME  -senv-var "${keys[$i]}=${values[$i]}" -overwrite ${keys[$i]} -tfe-address $TF_VAR_ATLAS_ADDRESS -token $TOKEN
  done
done