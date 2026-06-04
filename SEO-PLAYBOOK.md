# SEO playbook — Gal Tidhar + ZaZet Solutions

**Goal:** Maximum technical SEO + Search Console health on both sites.  
**Reality:** “100/100” in Lighthouse ≠ #1 on Google. You win **branded search**, **local SMB queries** (ZaZet), and **recruiter name search** (Gal).

---

## Site scores (technical — what we control)

| Site | On-page | Schema | Crawl | Your GSC |
|------|---------|--------|-------|----------|
| [gal.tidhar.org.il](https://gal.tidhar.org.il/) | ✅ Strong | ✅ ProfilePage + Person | ✅ sitemap Success | Verify → index homepage |
| [zazet-solutions.hr](https://zazet-solutions.hr/) | ✅ Strong (after deploy) | ✅ Local business + FAQ | ✅ sitemap exists | **Add property** (below) |

---

## YOU — Phase A (30 min, do today)

### A1. Gal — finish Search Console

Property `https://gal.tidhar.org.il/` — sitemap already **Success** ✅

1. **URL inspection** → `https://gal.tidhar.org.il/` → **Request indexing**
2. Same for `https://gal.tidhar.org.il/gal-tidhar-cv.pdf` (optional)

### A2. ZaZet — add Search Console (new property)

1. [Google Search Console](https://search.google.com/search-console) → **Add property** → `https://zazet-solutions.hr`
2. Verify (DNS TXT on `zazet-solutions.hr` **or** HTML file — same flow as Gal)
3. Submit sitemap: `https://zazet-solutions.hr/sitemap.xml`
4. **URL inspection** → homepage → **Request indexing**

### A3. Bing (5 min, both sites)

1. [Bing Webmaster Tools](https://www.bing.com/webmasters)
2. Import from Google Search Console *or* add both URLs manually
3. Submit both sitemaps

### A4. Cross-links (entity graph — high impact)

| From | Add link to |
|------|-------------|
| [GitHub profile](https://github.com/tatarco) | `https://gal.tidhar.org.il` + `https://zazet-solutions.hr` |
| [LinkedIn](https://www.linkedin.com/in/galtidhar/) | Featured: both URLs |
| ZaZet site footer | Already → gal.tidhar.org.il ✅ |
| Gal site | Already → zazet-solutions.hr ✅ |

### A5. Re-scrape social (2 min each)

- Gal: [Facebook Debugger](https://developers.facebook.com/tools/debug/?q=https://gal.tidhar.org.il/) → Scrape Again
- ZaZet: same for `https://zazet-solutions.hr/`
- Gal: [Rich Results Test](https://search.google.com/test/rich-results?url=https://gal.tidhar.org.il/)

---

## YOU — Phase B (local SEO for ZaZet — biggest growth lever)

Google Business Profile beats perfect meta tags for “automatizacija Zagreb”.

1. [Google Business Profile](https://business.google.com) → create **ZaZet Solutions**
2. Category: *Software company* or *Business management consultant*
3. Service area: Zagreb + Croatia (you work remote)
4. Website: `https://zazet-solutions.hr`
5. Add 5+ photos, short description in HR, link to Cal/WhatsApp
6. Ask 2–3 happy clients for reviews (when ready)

---

## YOU — Phase C (optional polish)

| Task | Why |
|------|-----|
| Facebook `fb:app_id` on Gal | Clears debugger warning — [create app](https://developers.facebook.com/apps), paste ID to agent |
| PageSpeed Insights both URLs | Fix only if LCP/INP red — [pagespeed.web.dev](https://pagespeed.web.dev/) |
| Google Analytics Search Console linking | Already have GA on ZaZet (`G-Q0JMCN6F5T`) — link in GA Admin → Search Console |

---

## AGENT — deployed / ready to push

### Gal (`tatarco/gal-tidhar`) — live

- Verification file, sitemap, schema, `og.png`, `llms.txt`, robots

### ZaZet (`tatarco/zazet-solutions`) — **push to deploy**

```bash
cd /Users/galtidhar/PycharmProjects/zazet-solutions
git add index.html sitemap.xml llms.txt accessibility.html .well-known/security.txt SEO-PLAYBOOK.md
git commit -m "SEO: trim meta, llms.txt, WebPage schema, sitemap cleanup."
git push origin main
```

Changes:
- Meta description trimmed to SERP length (~155 chars)
- `llms.txt` + `rel=me` + `og:image:alt`
- `WebPage` schema + richer `Person` (GitHub, gal.tidhar)
- Sitemap: ISO dates, removed `privacy.html` (it’s `noindex`)
- `accessibility.html` canonical + meta
- `security.txt`

---

## What “perfect” cannot fix (set expectations)

| Myth | Truth |
|------|--------|
| FAQ rich snippets on ZaZet | Google limited FAQ rich results to gov/health sites — schema still helps understanding, not stars in SERP |
| Instant rankings | New GSC property → 3–14 days for first impressions |
| Gal ranks “staff engineer jobs” | Portfolio wins **name + brand** queries, not generic job boards |
| ZaZet vs Gal keyword collision | By design: Gal = engineering hire; ZaZet = SMB automation — different intents |

---

## Monthly 10-min routine

1. Search Console → Performance → both properties — any queries worth a FAQ line?
2. Sitemaps → still Success?
3. One new backlink (guest post, client site, directory) per month if you want growth

---

## Send agent when ready

- Google verification file/string for **zazet-solutions.hr**
- Facebook **App ID** for Gal (optional)
- PageSpeed screenshot if something scores &lt; 90 — we tune assets
