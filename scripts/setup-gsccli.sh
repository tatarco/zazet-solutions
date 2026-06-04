#!/usr/bin/env bash
# Install gsccli locally (avoids broken global Homebrew npm installs).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

echo "Cleaning broken global gsccli (if any)..."
npm uninstall -g @nalyk/gsccli 2>/dev/null || true
rm -rf /opt/homebrew/lib/node_modules/@nalyk/gsccli 2>/dev/null || true

echo "Installing gsccli locally in scripts/ ..."
npm install

GSCCLI="$ROOT/node_modules/.bin/gsccli"
if [[ ! -x "$GSCCLI" ]]; then
  echo "Install failed — no gsccli binary."
  exit 1
fi

echo ""
echo "Installed: $("$GSCCLI" --version 2>/dev/null || echo ok)"
echo ""
echo "=== Next: Google OAuth (one time, ~10 min) ==="
echo "1. https://console.cloud.google.com/"
echo "2. Enable APIs: Search Console API + Web Search Indexing API"
echo "3. Credentials → OAuth client → Desktop → Download JSON"
echo "4. Run:"
echo "   $GSCCLI config set oauthClientSecretFile ~/Downloads/client_secret_XXXX.json"
echo "   $GSCCLI auth login"
echo ""
echo "Or use the wrapper:"
echo "   ./scripts/gsc.sh auth login"
echo ""
echo "When done, tell Cursor: GSC auth done"
