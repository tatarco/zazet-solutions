#!/usr/bin/env bash
# Ping Bing/Yandex via IndexNow after deploy. No account required.
set -euo pipefail

HOST="${1:-zazet-solutions.hr}"
KEY_FILE="$(dirname "$0")/../778926061984e55c87161dd9246da56d.txt"
KEY="$(tr -d '[:space:]' < "$KEY_FILE")"

if [[ -z "$KEY" ]]; then
  echo "Missing key file. Deploy ${KEY_FILE##*/} to site root first."
  exit 1
fi

JSON=$(python3 -c "
import json
print(json.dumps({
  'host': '$HOST',
  'key': '$KEY',
  'keyLocation': 'https://$HOST/$KEY.txt',
  'urlList': [
    'https://$HOST/',
    'https://$HOST/accessibility.html'
  ]
}))
")

echo "Submitting to IndexNow for $HOST ..."
curl -sS -w " indexnow:%{http_code}\n" -X POST "https://api.indexnow.org/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" -d "$JSON"
curl -sS -w " bing:%{http_code}\n" -X POST "https://www.bing.com/indexnow" \
  -H "Content-Type: application/json; charset=utf-8" -d "$JSON"
echo "Done."
