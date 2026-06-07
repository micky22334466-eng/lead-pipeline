<div align="center">
  <img src="https://img.shields.io/badge/100%25-FREE_FOREVER-22d3ee?style=for-the-badge&logo=github&logoColor=white&labelColor=03050a" alt="100% FREE FOREVER" />
  <img src="https://img.shields.io/badge/OPEN-SOURCE-2ef2c3?style=for-the-badge&logo=opensourceinitiative&logoColor=white&labelColor=03050a" />
  <img src="https://img.shields.io/badge/MIT-LICENSE-f6c76a?style=for-the-badge&labelColor=03050a" />
</div>

# 🚀 LeadPipeline — The 100% Free Apollo Alternative

**Scrape → Pitch → Demo → Close.** The only complete open-source sales pipeline. No credit card. No trial. No $49/mo. Just results.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.10+](https://img.shields.io/badge/Python-3.10%2B-blue.svg)](https://www.python.org/)
[![GitHub stars](https://img.shields.io/github/stars/AI-Invention/lead-pipeline)](https://github.com/AI-Invention/lead-pipeline/stargazers)

> **💰 Save $588/year vs Apollo.** Same pipeline. Zero cost. Self-hosted. Forever.

## ❓ Why LeadPipeline?

In 2026, paying $49/mo for lead generation is unnecessary. Big companies are going open-source. So should you.

Most tools only do ONE thing — scrape leads, OR send emails, OR track replies. LeadPipeline is the first to deliver the **complete pipeline** — free:

```
Google Maps Scraper → Google Sheets CRM → Personalized Pitches → Demo Showcase → Reply Tracking
```

**Zero API costs. Zero subscriptions. Just Python + free tools.**

## ⚡ Quick Start

```bash
# 1. Clone
git clone https://github.com/AI-Invention/lead-pipeline.git
cd lead-pipeline

# 2. Install
pip install -r requirements.txt

# 3. Configure
cp scraper/config.py.example scraper/config.py
cp outreach/config.py.example outreach/config.py
# Edit config.py with your API keys + SMTP credentials

# 4. Run
python scraper/apify_scraper.py     # Scrape Google Maps leads
python outreach/pitch_sender.py     # Send personalized emails
python demo/deploy_landing.sh       # Deploy demo showcase
```

## 🏗️ Architecture

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Google Maps    │ ──► │  Google Sheets   │ ──► │  SMTP Email     │
│  Scraper        │     │  (CRM Database)  │     │  (Pitch)        │
│  (Apify/Free)   │     │  Free tier       │     │  Hostinger/Gmail │
└─────────────────┘     └──────────────────┘     └─────────────────┘
                                                          │
                                                          ▼
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│  Reply          │ ◄── │  Demo            │ ◄── │  Client         │
│  Tracker        │     │  Showcase        │     │  Views Demo     │
│  (IMAP check)   │     │  (Static HTML)   │     │                  │
└─────────────────┘     └──────────────────┘     └─────────────────┘
```

## 📦 What's Inside

| Component | File | What It Does |
|-----------|------|-------------|
| 🔍 **Scraper** | `scraper/apify_scraper.py` | Scrapes Google Maps for businesses (name, phone, website, address) |
| 📊 **CRM** | `sheets/google_sheets.py` | Writes leads to Google Sheets — free tier (15 GB) |
| ✉️ **Outreach** | `outreach/pitch_sender.py` | Personalized cold emails via SMTP with BCC tracking |
| 🌐 **Demo** | `demo/landing.html` | Luxury dark-theme landing page to showcase client demos |
| 📬 **Reply** | `outreach/reply_checker.py` | IMAP inbox scanner — detects bounces + warm replies |

## 🎨 Demo Showcase Landing

Every pitch includes a link to YOUR demo landing page:

```
https://demo.yourdomain.com/
```

Multiple client demos, one beautiful page. Dark theme, gradient accents, professional cards.

![Demo Preview](demo/preview.png)

## 🛠️ Setup Guide

### 1. Apify API Key (Free Tier)
1. Sign up at [apify.com](https://apify.com) — free $5/month
2. Get API key from Settings → Integrations
3. Add to `scraper/config.py`

### 2. Google Sheets API
1. Create service account at [Google Cloud Console](https://console.cloud.google.com)
2. Enable Google Sheets API
3. Download JSON key → save to `sheets/credentials.json`
4. Share your Sheet with the service account email

### 3. SMTP Setup
- **Gmail:** Use App Password (Settings → Security → 2FA → App Passwords)
- **Hostinger:** Use your business email credentials
- Add to `outreach/config.py`

### 4. Demo Landing Page
```bash
# Deploy with Docker
cd demo
docker build -t demo-landing .
docker run -d -p 80:80 --name demo-landing demo-landing
```

Or deploy to any static host (Netlify, Vercel, GitHub Pages).

## 🌍 Real-World Use Cases

- **Marketing agencies:** Generate leads for 10+ clients simultaneously
- **Freelancers:** Find + pitch 50 businesses daily — automated
- **SaaS startups:** Build your first 100-customer pipeline
- **AI agents:** Integrate with your existing agent for end-to-end sales

## 💰 Pricing — $0 vs $588/year

| | Apollo.io | Lemlist | **LeadPipeline** |
|---|:---:|:---:|:---:|
| **Monthly Cost** | $49 | $32 | **$0** |
| **Annual Cost** | $588 | $384 | **$0** |
| Google Maps Scraper | Basic | ❌ | ✅ Full |
| Email Outreach | ✅ | ✅ | ✅ Unlimited |
| Reply Tracking | ✅ | ✅ | ✅ |
| Demo Showcase | ❌ | ❌ | ✅ |
| Open Source | ❌ | ❌ | ✅ |
| Self-Hosted | ❌ | ❌ | ✅ |
| No Credit Card | ❌ | ❌ | ✅ |

> **🆓 Forever free. No catch. No credit card. No "free trial" that expires. Just clone and run.**

## 🗺️ 2026 Roadmap — What Big Companies Are Building

- [x] Google Maps scraping (Apify)
- [x] SMTP email outreach
- [x] Google Sheets CRM
- [x] Demo landing page
- [x] Reply tracking (IMAP)
- [ ] Web UI dashboard (coming Q3 2026)
- [ ] LinkedIn lead finder (coming Q3 2026)
- [ ] AI-powered pitch personalization (coming Q3 2026)
- [ ] Multi-channel (WhatsApp, SMS)

**Watch this repo for the hosted SaaS launch!**

## 🤝 Contributing

Open an issue or PR! We're building the best free lead gen pipeline. All contributions welcome.

## 📄 License

MIT — use freely, modify, sell. Just credit AI Invention.

---

### ⭐ Star this repo if you find it useful!

Built with ❤️ by [AI Invention](https://aiinvention.tech)
