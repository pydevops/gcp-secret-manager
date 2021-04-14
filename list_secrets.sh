#!/usr/bin/env bash
set -eu
ROOT=$(dirname "${BASH_SOURCE[0]}")
source "$ROOT"/functions.sh
gcloud secrets list --project ${PROJECT}