#!/bin/bash

set -e # Exit on any errors

# Get the directory of this script:
# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

NPM_LOCK="$DIR/package-lock.json"
if test -f "$NPM_LOCK"; then
  NPM_LOCK_EXISTS=1
  rm -f "$NPM_LOCK"
  echo "Successfully deleted: $NPM_LOCK"
fi

YARN_LOCK="$DIR/yarn.lock"
if test -f "$YARN_LOCK"; then
  YARN_LOCK_EXISTS=1
  rm -f "$YARN_LOCK"
  echo "Successfully deleted: $YARN_LOCK"
fi

PNPM_LOCK="$DIR/pnpm-lock.yaml"
if test -f "$PNPM_LOCK"; then
  PNPM_LOCK_EXISTS=1
  rm -f "$PNPM_LOCK"
  echo "Successfully deleted: $PNPM_LOCK"
fi

NODE_MODULES="$DIR/node_modules"
if test -d "$NODE_MODULES"; then
  rm -rf "$NODE_MODULES"
  echo "Successfully deleted: $NODE_MODULES"
fi

if [[ -z "$NPM_LOCK_EXISTS" && -z "$YARN_LOCK_EXISTS" && -z "$PNPM_LOCK_EXISTS" ]]; then
  echo "No package manager lock files were found. You should manually invoke the package manager that you want to use for this project. e.g. \"npm install\""
  exit 1
elif [[ ! -z "$NPM_LOCK_EXISTS" && -z "$YARN_LOCK_EXISTS" && -z "$PNPM_LOCK_EXISTS" ]]; then
  npm install
elif [[ -z "$NPM_LOCK_EXISTS" && ! -z "$YARN_LOCK_EXISTS" && -z "$PNPM_LOCK_EXISTS" ]]; then
  yarn install
elif [[ -z "$NPM_LOCK_EXISTS" && -z "$YARN_LOCK_EXISTS" && ! -z "$PNPM_LOCK_EXISTS" ]]; then
  pnpm install
else
  echo "Error: Multiple different kinds of package manager lock files were found. You should manually invoke the package manager that you want to use for this project. e.g. \"npm install\""
  exit 1
fi

echo "Successfully reinstalled Node dependencies."
