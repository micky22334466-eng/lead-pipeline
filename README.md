# LeadPipeline

**Free, open-source lead generation and outreach automation. Scrape → Pitch → Demo → Close.**

LeadPipeline is a complete outbound sales pipeline: scrape business leads from Google Maps, store them in a Google Sheets CRM, send personalized pitches over SMTP, showcase your work on a demo landing page, and track replies — all self-hosted, with zero subscription costs.

[![License: MIT](https://img.shields.io/badge/license-MIT-22d3ee?style=flat-square&labelColor=03050a)](https://opensource.org/licenses/MIT)
[![Python 3.10+](https://img.shields.io/badge/python-3.10+-22d3ee?style=flat-square&labelColor=03050a)](https://www.python.org/)
[![Website](https://img.shields.io/badge/website-aiinvention.tech-22d3ee?style=flat-square&labelColor=03050a)](https://aiinvention.tech)

---

## How It Works

```
Scrape → Pitch → Demo → Close
```

1. **Scrape** — Google Maps business leads via Apify (free tier)
2. **Pitch** — Personalized cold emails over SMTP
3. **Demo** — A dark-themed landing page showcasing your work
4. **Close** — Reply tracking so you never miss a warm lead

---

## Features

- **Google Maps scraping** — name, phone, website, address (`scraper/`)
- **Google Sheets CRM** — free tier, no database required (`sheets/`)
- **SMTP outreach** — personalized pitches with BCC tracking (`outreach/`)
- **Demo showcase** — static landing page for client demos (`demo/`)
- **Reply tracking** — IMAP scanner for bounces and warm replies (`outreach/`)

---

## Quick Start

```bash
git clone https://github.com/AI-Invention/lead-pipeline.git
cd lead-pipeline

pip install -r requirements.txt

cp scraper/config.py.example scraper/config.py
cp outreach/config.py.example outreach/config.py
# edit configs with your API keys + SMTP credentials

python scraper/apify_scraper.py     # scrape leads
python outreach/pitch_sender.py     # send pitches
python outreach/reply_checker.py    # track replies
```

The demo landing page (`demo/landing.html`) is static — deploy it to any host (Netlify, Vercel, GitHub Pages, or your VPS).

---

## Requirements

- Python 3.10+
- Apify account (free tier)
- Google Cloud service account with Sheets API enabled
- SMTP credentials (Gmail app password or business email)

---

## License

MIT — use it freely, modify it, sell it. Credit AI Invention.

---

Built by [AI Invention](https://aiinvention.tech) — AI automation for real businesses.
