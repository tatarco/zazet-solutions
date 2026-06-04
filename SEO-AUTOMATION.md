# SEO automation — what the agent can run vs what you set up once

## The honest answer

| Task | Fully automatic? | Tool |
|------|------------------|------|
| Meta, schema, sitemap, robots | ✅ Agent edits + git push | Code |
| **IndexNow** (Bing/Yandex ping) | ✅ After deploy | `scripts/submit-indexnow.sh` |
| **GSC sitemap / inspect / analytics** | ⚠️ One-time login, then agent | **gsccli** |
| GSC property **verification** | ❌ You (DNS or HTML file) | Browser |
| Request indexing (UI button) | ⚠️ Same as gsccli inspect | gsccli / leo |
| Google Business Profile | ❌ You | business.google.com |
| Facebook `fb:app_id` | ❌ You | developers.facebook.com |
| PageSpeed / CrUX | ⚠️ Free API key once | `seo-google` skill or PSI API |

**Nobody can add your site to Search Console without your Google account.** After ~15 min OAuth setup, the agent can run the rest from the terminal.

---

## Recommended CLI: [gsccli](https://github.com/nalyk/gsccli)

Best fit for Cursor/agents: OAuth login, sitemaps, URL inspection, optional Indexing API, MCP server for read-only queries.

### One-time setup (you — ~15 min)

```bash
npm install -g gsccli
gsccli auth login
```

Browser opens → sign in with the Google account that owns Search Console.

Add both properties in [Search Console](https://search.google.com/search-console) first (Gal already verified; ZaZet needs verification file when you push).

Optional — service account (for CI / no browser):

1. [Google Cloud Console](https://console.cloud.google.com/) → new project → enable **Search Console API**
2. Create service account → download JSON key
3. Search Console → Settings → Users → add service account email as **Owner**
4. `gsccli config set service_account_path /path/to/key.json`

### What the agent runs after login

```bash
# List properties
gsccli sites list

# Submit sitemaps
gsccli sitemaps submit https://gal.tidhar.org.il/sitemap.xml --site sc-domain:tidhar.org.il
# or URL-prefix property:
gsccli sitemaps submit https://gal.tidhar.org.il/sitemap.xml --site https://gal.tidhar.org.il/

gsccli sitemaps submit https://zazet-solutions.hr/sitemap.xml --site https://zazet-solutions.hr/

# Inspect + see index status
gsccli inspect url https://gal.tidhar.org.il/
gsccli inspect url https://zazet-solutions.hr/

# Search performance (after data exists)
gsccli query top-queries --site https://gal.tidhar.org.il/ --days 28
```

Tell the agent: **“GSC auth is done — run gsccli for both sites.”**

---

## Alternatives

| Tool | Install | Notes |
|------|---------|-------|
| [gsc-cli](https://github.com/awkoy/gsc-cli) | `npm i -g gsc-cli` | `gsc inspect --sitemap`, clean UX |
| [leo](https://github.com/cliftonc/leo) | `npm i -g leo` | `leo auto` pipeline: sitemap → inspect → submit |
| [gsc-url-indexer](https://github.com/theriturajps/gsc-url-indexer) | Python | Service account + sitemap batch |

**Indexing API** (`gsccli index publish`): Google’s docs say JobPosting/BroadcastEvent only; personal portfolios often use URL Inspection + sitemap instead (what GSC UI “Request indexing” does).

---

## Skills in your stack

| Skill | What it needs |
|-------|----------------|
| `seo-google` (`.agents/skills/seo-google`) | `~/.config/claude-seo/google-api.json` — service account or API key |
| `kostja94/marketing-skills@google-search-console` | `npx skills add kostja94/marketing-skills@google-search-console` |
| `jdrhyne/agent-skills@gsc` | GSC-focused agent skill |

Install marketing GSC skill:

```bash
npx skills add kostja94/marketing-skills@google-search-console
```

Still requires the same Google credentials as gsccli.

---

## IndexNow (already wired — no account)

After each deploy:

```bash
# ZaZet (from repo root)
chmod +x scripts/submit-indexnow.sh
./scripts/submit-indexnow.sh

# Gal (gal-tidhar repo)
./scripts/submit-indexnow.sh
```

Key files must be live:

- https://gal.tidhar.org.il/6ba1cae03c1ec6ba61a2f3b19421056a.txt
- https://zazet-solutions.hr/778926061984e55c87161dd9246da56d.txt

---

## Fastest path for you

1. **Push ZaZet** SEO commit (if not done).
2. **`npm install -g gsccli && gsccli auth login`** (one time).
3. Message agent: *“GSC logged in — submit sitemaps, inspect both homepages, run IndexNow.”*
4. **Google Business Profile** for ZaZet (still manual, highest ROI).
