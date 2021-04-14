#!/usr/bin/env bash
set -eu

ROOT=$(dirname "${BASH_SOURCE[0]}")
source "$ROOT"/functions.sh

create_secret TFE_LICENSE license.rli
