# SEO automation — completed vs your turn

Last run: 2026-06-04

## Done automatically

| Action | Gal | ZaZet |
|--------|-----|-------|
| SEO meta, schema, sitemap, robots, llms.txt | Live | Pushed `1195417` + `6d97e6c` |
| IndexNow → Bing/Yandex | **200/200** | **202/200** |
| GSC verification file | `google3055b630a8d0d46c.html` live | Add property in GSC → new file |
| IndexNow key file | Live | Live |
| `security.txt` | Live | Live |
| gsccli installed | `npm install github:nalyk/gsccli` | same |

## Blocked — needs you (~15 min once)

### GSC CLI (`gsccli`)

`gsccli auth login` needs **Google Cloud OAuth client JSON** (not just Search Console UI).

```bash
chmod +x scripts/setup-gsccli.sh
./scripts/setup-gsccli.sh
```

Follow the steps, then message: **GSC auth done**.

### ZaZet Search Console property

1. [Search Console](https://search.google.com/search-console) → Add `https://zazet-solutions.hr`
2. Verify (DNS or new HTML file — **not** the Gal file)
3. Submit `sitemap.xml`
4. Request indexing on homepage

### Gal Search Console

Sitemap already **Success**. Still do:

- URL inspection → `https://gal.tidhar.org.il/` → **Request indexing**

### Optional (manual, high ROI)

- Google Business Profile (ZaZet)
- GitHub + LinkedIn featured links to both sites
- Facebook App ID → paste to agent for `fb:app_id`

## Re-run IndexNow after future deploys

```bash
# Gal
bash /path/to/gal-tidhar/scripts/submit-indexnow.sh

# ZaZet
./scripts/submit-indexnow.sh
```
