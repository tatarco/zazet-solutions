#!/usr/bin/env bash
# Wrapper — always uses local gsccli from scripts/node_modules
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
if [[ ! -x "$ROOT/node_modules/.bin/gsccli" ]]; then
  echo "Run: ./scripts/setup-gsccli.sh"
  exit 1
fi
exec "$ROOT/node_modules/.bin/gsccli" "$@"
