#!/usr/bin/env bash

set -o errexit
set -o pipefail

if [[ -z "$UPDATE_USER" ]]; then
    UPDATE_USER="$USER"
fi
echo ">> Updatin' user: '$UPDATE_USER'"

[[ -z "$UPDATE_ROOT" ]] && UPDATE_ROOT="./"
echo ">> Updatin' root: '$UPDATE_ROOT'"

ansible-playbook \
    "$UPDATE_ROOT"playbooks/update.yml \
    -e "user=$UPDATE_USER" \
    -i "$UPDATE_ROOT"environments/local \
    --ask-become-pass

