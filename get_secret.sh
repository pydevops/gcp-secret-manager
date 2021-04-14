#!/usr/bin/env bash
set -eu

[[ "$#" -eq 0 ]] && { echo "$0 <secret_name>";exit; }

ROOT=$(dirname "${BASH_SOURCE[0]}")
source "$ROOT"/functions.sh
gcloud secrets versions access latest --secret=$1