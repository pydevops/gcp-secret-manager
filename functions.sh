#!/usr/bin/env bash

# "---------------------------------------------------------"
# "-                                                       -"
# "-  Common variables or functions for all scripts        -"
# "-                                                       -"
# "---------------------------------------------------------"
command -v gcloud >/dev/null 2>&1 || { \
 echo >&2 "I require gcloud but it's not installed.  Aborting."; exit 1; }

PROJECT="$(gcloud config get-value core/project 2>/dev/null)"
if [[ -z "${PROJECT}" ]]; then
    echo "gcloud cli must be configured with a default project." 1>&2
    echo "run 'gcloud config set core/project PROJECT'." 1>&2
    echo "replace 'PROJECT' with the project name." 1>&2
    exit 1;
fi

create_secret () {
  local SECRET_ID=$1
  local SECRET_FILE="$2"
  if ! gcloud secrets describe $SECRET_ID
  then 
     gcloud secrets create $SECRET_ID --replication-policy="automatic" --project ${PROJECT}
  fi 
  gcloud secrets versions add $SECRET_ID  --data-file="$SECRET_FILE"
}

create_secrets () {
  local secrets=$1
  while IFS== read -r key value ; do
      echo "$key, $value"
      create_secret $key $value
  done < $secrets
}


delete_secrets () {
  local secrets=$1
  while IFS== read -r key value ; do
      echo "$key to be deleted:"
      gcloud secrets delete $key --project ${PROJECT} --quiet
  done < $secrets
}