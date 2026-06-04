#!/usr/bin/env bash
# One-time Google Search Console CLI setup for gsccli.
# Run in Terminal (opens browser). After this, the agent can run gsccli for you.
set -euo pipefail

echo "Installing gsccli..."
npm install -g github:nalyk/gsccli

echo ""
echo "=== OAuth setup (recommended) ==="
echo "1. https://console.cloud.google.com/ → Create/select project"
echo "2. APIs & Services → Enable: Search Console API, Web Search Indexing API"
echo "3. Credentials → Create OAuth client → Desktop app → Download JSON"
echo "4. Run:"
echo "   gsccli config set oauthClientSecretFile ~/Downloads/client_secret_XXXX.json"
echo "   npx @nalyk/gsccli auth login"
echo ""
echo "=== Then tell Cursor: GSC auth done ==="
echo ""
echo "Agent commands:"
echo "  npx @nalyk/gsccli sitemaps submit https://gal.tidhar.org.il/sitemap.xml --site https://gal.tidhar.org.il/"
echo "  npx @nalyk/gsccli sitemaps submit https://zazet-solutions.hr/sitemap.xml --site https://zazet-solutions.hr/"
echo "  npx @nalyk/gsccli inspect url https://gal.tidhar.org.il/"
echo "  npx @nalyk/gsccli inspect url https://zazet-solutions.hr/"
