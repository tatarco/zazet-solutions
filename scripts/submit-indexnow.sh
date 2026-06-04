#!/usr/bin/env bash
# Ping Bing/Yandex via IndexNow after deploy. No account required.
set -euo pipefail

HOST="${1:-zazet-solutions.hr}"
KEY_FILE="$(dirname "$0")/../778926061984e55c87161dd9246da56d.txt"
KEY="$(cat "$KEY_FILE" 2>/dev/null || echo '')"

if [[ -z "$KEY" ]]; then
  echo "Missing key file. Deploy 6ba1cae03c1ec6ba61a2f3b19421056a.txt to site root first."
  exit 1
fi

URLS=(
  "https://${HOST}/"
  "https://${HOST}/accessibility.html"
)

JSON=$(python3 - <<PY
import json
urls = """${URLS[*]}""".split()
print(json.dumps({
  "host": "$HOST",
  "key": "$KEY",
  "keyLocation": f"https://{HOST}/$KEY.txt",
  "urlList": urls
}))
PY
)

echo "Submitting to IndexNow for $HOST ..."
curl -sS -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "$JSON"
echo
curl -sS -X POST "https://www.bing.com/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d "$JSON"
echo
echo "Done."
