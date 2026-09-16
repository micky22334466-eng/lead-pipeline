# Handyman Lead Scraper Integration Guide

Complete guide to setting up and running the scraper integration for your handyman business leads.

## 📋 Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Installation](#installation)
4. [Configuration](#configuration)
5. [Running Scrapers](#running-scrapers)
6. [Importing Leads](#importing-leads)
7. [Dashboard Integration](#dashboard-integration)
8. [Troubleshooting](#troubleshooting)

---

## Overview

The scraper integration automates the process of finding handyman businesses and converting them into qualified leads in your pipeline.

**What it does:**
- 🔍 Scrapes business data from Google Maps for handyman-related services
- 📊 Enriches data with ratings, reviews, and contact information
- ✅ Validates and deduplicates leads
- 📈 Estimates project budgets based on business quality
- 💾 Imports into lead pipeline dashboard

**Expected results:**
- 50-200 new leads per scraping session
- Quality score of 50-80 for established businesses
- Contact information (phone/email) for 80%+ of leads

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│  Google Maps Scraper / Scrapegraph AI                       │
│  (Extracts business data)                                   │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│  Scraper Integration Module                                 │
│  (Transform, validate, enrich)                              │
│  - scraper_integration.py                                   │
│  - scraper_config.py                                        │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│  Lead Import API                                            │
│  (Deduplication, scoring)                                   │
│  - scraper_api.py                                           │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│  Lead Pipeline Dashboard                                    │
│  (Manage and track leads)                                   │
│  - punchlist-lead-desk.html                                 │
└─────────────────────────────────────────────────────────────┘
```

---

## Installation

### Step 1: Install Dependencies

```bash
cd /home/user/lead-pipeline

# Install required packages
pip install -r requirements.txt

# Optional: Flask for API server
pip install flask
```

### Step 2: Set Up Directory Structure

```bash
# Create directories for scraped data and logs
mkdir -p data
mkdir -p scraper_logs
mkdir -p output

# Create empty data files
touch data/imported_leads.json
touch data/import_log.json
```

### Step 3: Verify Installation

```bash
# Test the integration module
python scraper_integration.py

# You should see output like:
# ╔══════════════════════════════════════════════════════════════╗
# ║         HANDYMAN SCRAPER IMPORT REPORT                      ║
# ...
```

---

## Configuration

### Main Configuration File: `scraper_config.py`

Located in `/home/user/lead-pipeline/scraper_config.py`

#### Service Categories to Scrape

```python
HANDYMAN_SEARCH_QUERIES = {
    "general_handyman": {
        "queries": ["handyman near me", "handyman services"],
        "job_type": "multi",
        "min_budget": "b",
        "max_budget": "d"
    },
    "plumbing": {
        "queries": ["plumber near me"],
        "job_type": "single",
        "min_budget": "a",
        "max_budget": "c"
    },
    # ... more services
}
```

**Available job types:**
- `small` - Small tasks ($6 base)
- `single` - Single repairs ($14 base)
- `multi` - Multi-trade repairs ($24 base)
- `remodel` - Full remodels ($48 base)

#### Target Locations

```python
TARGET_LOCATIONS = [
    "Dallas, TX",
    "Houston, TX",
    "Austin, TX",
    # Add your target cities
]
```

#### Quality Filters

```python
QUALITY_FILTERS = {
    "min_rating": 3.5,           # Only 3.5+ rated
    "min_reviews": 5,            # At least 5 reviews
    "require_phone": True,       # Must have phone
    "require_website": False,    # Website optional
}
```

**Customize these settings:**

1. **For high-quality leads only:**
   ```python
   "min_rating": 4.5,
   "min_reviews": 50,
   ```

2. **For quantity (include newer businesses):**
   ```python
   "min_rating": 3.0,
   "min_reviews": 3,
   ```

3. **For specific services:**
   ```python
   TARGET_LOCATIONS = ["Your City, TX"]
   HANDYMAN_SEARCH_QUERIES = {
       "your_service": { ... }
   }
   ```

---

## Running Scrapers

### Option 1: Using Google Maps Scraper (Recommended)

The Google Maps Scraper is the most effective for this use case.

**Step 1: Install and Configure**

```bash
cd /home/user/google-maps-scraper

# Follow their README
# Download the desktop app or use the API
```

**Step 2: Run Scraper**

```bash
# Using the desktop app:
# 1. Open Google Maps Extractor
# 2. Enter search query: "handyman near me"
# 3. Enter location: "Dallas, TX"
# 4. Click Run
# 5. Export results as CSV/JSON

# Using the API (Python):
from botasaurus_api import api

result = api.get_google_maps_data(
    queries=["handyman near me"],
    locations=["Dallas, TX"],
    max_results=1000
)

# Save results
import json
with open("scraped_businesses.json", "w") as f:
    json.dump(result, f)
```

**Step 3: Export Data**

Export as JSON file to `/home/user/lead-pipeline/scraped_businesses.json`

Example format:
```json
[
  {
    "business_name": "ABC Handyman",
    "phone": "(555) 123-4567",
    "website": "abchandyman.com",
    "address": "123 Main St, Dallas TX",
    "rating": 4.8,
    "review_count": 45,
    "email": "info@abchandyman.com",
    "category": "Handyman Services"
  }
]
```

### Option 2: Using Scrapegraph AI

For more complex data extraction:

```bash
cd /home/user/scrapegraph-ai

# Follow their documentation
# Configure API key and scraping rules
```

---

## Importing Leads

### Method 1: Command Line Import

```bash
cd /home/user/lead-pipeline

# Import from scraped_businesses.json
python scraper_api.py

# This will:
# 1. Read scraped_businesses.json
# 2. Transform to lead format
# 3. Validate data
# 4. Deduplicate
# 5. Save to data/imported_leads.json
```

### Method 2: Flask API Server

**Start the server:**

```bash
cd /home/user/lead-pipeline

python scraper_api.py
```

**Import via HTTP:**

```bash
curl -X POST http://localhost:5000/api/leads/import \
  -H "Content-Type: application/json" \
  -d @scraped_businesses.json
```

**Or use Python:**

```python
import requests
import json

with open("scraped_businesses.json", "r") as f:
    businesses = json.load(f)

response = requests.post(
    "http://localhost:5000/api/leads/import",
    json={"businesses": businesses}
)

result = response.json()
print(f"Imported: {result['data']['imported']} leads")
```

### Method 3: Automated Scheduling

**Setup daily scraping with cron:**

```bash
# Edit crontab
crontab -e

# Add this line for daily scraping at 9 AM:
0 9 * * * cd /home/user/lead-pipeline && python scraper_api.py

# For multiple times per day (9 AM and 6 PM):
0 9,18 * * * cd /home/user/lead-pipeline && python scraper_api.py
```

---

## Dashboard Integration

### Viewing Imported Leads

**Step 1: Open Dashboard**

```bash
# Open in browser:
/home/user/lead-pipeline/punchlist-lead-desk.html
```

**Step 2: View Imported Leads**

1. Click "Board" tab
2. Filter by "Source: Google Maps"
3. Sort by "Score" (highest first)

**Step 3: Prioritize Outreach**

- 🔴 **Red (70+):** Hot leads - contact immediately
- 🟡 **Gold (45-69):** Warm leads - follow up this week
- 🔵 **Blue (<45):** Cold leads - nurture for later

### Lead Score Breakdown

Imported leads get scores based on:

| Factor | Points | Source |
|--------|--------|--------|
| Rating (4.5+) | +5 | Business quality |
| 100+ Reviews | +4 | Established business |
| Has Phone | +3 | Contact info |
| Has Website | +2 | Professional |
| Verified Email | +4 | Validated contact |
| Job Type | 5-20 | Service category |
| Budget | 5-30 | Business size |
| Timeline | 3-25 | Assumed "Planning" |

**Example:**
- Established plumbing company (rating 4.8, 150 reviews) = 60-70 base score
- Plus contact info bonuses = 70-85 total
- **Result: Hot lead ready to contact**

---

## Workflow: From Scrape to Close

### Week 1: Initial Scrape

```
1. Run scraper for 2-3 cities
2. Import 100-300 businesses
3. Review in dashboard
4. Identify hot leads (70+)
→ 20-30 hot leads ready
```

### Week 2: Initial Outreach

```
1. Contact red leads (70+)
2. Send personalized messages
3. Track responses in "Status" field
4. Move to "Contacted" in pipeline
→ 5-15 positive responses
```

### Week 3: Qualification

```
1. Follow up with interested leads
2. Qualify opportunities
3. Move to "Quoted" status
4. Send proposals
→ 2-5 qualified opportunities
```

### Week 4: Closing

```
1. Follow up on proposals
2. Negotiate terms
3. Move to "Won" status
4. Track revenue
→ 1-3 closed deals
```

---

## Outreach Templates

### Initial Contact (SMS/Email)

```
Hi [Name],

I noticed [Business Name] has great reviews for 
[service type]. We work with contractors like 
you on [value proposition].

Would you be open to a quick 15-min call 
this week?

[Your name]
[Phone]
```

### Follow-Up (After No Response)

```
Hi [Name],

Just following up on my previous message about
[opportunity]. No pressure - just wanted to make
sure you saw it.

Happy to chat when you have time.

Thanks,
[Your name]
```

---

## Troubleshooting

### Issue: "No leads imported"

**Check:**
1. Verify `scraped_businesses.json` exists and has data
2. Check quality filters in `scraper_config.py`
3. Run validation: `python scraper_integration.py`

**Solution:**
```python
# Temporarily lower quality filters
QUALITY_FILTERS = {
    "min_rating": 3.0,      # Lower from 3.5
    "min_reviews": 2,       # Lower from 5
}
```

### Issue: "Duplicate leads"

**Expected behavior:**
- System deduplicates by phone, email, and name+city
- This prevents contacting the same business twice

**If you want to allow duplicates:**
```python
IMPORT_CONFIG = {
    "deduplicate": False,  # Allow duplicates
}
```

### Issue: "Wrong job type assigned"

**Check the mapping:**
```python
SERVICE_TO_JOB_TYPE = {
    "handyman": "multi",
    "plumber": "single",
    # Add custom mappings
}
```

**Update mappings:**
```python
SERVICE_TO_JOB_TYPE = {
    "your_service": "remodel",  # Add custom
}
```

### Issue: "Dashboard not showing imported leads"

**Solution:**
1. Clear browser cache
2. Open dashboard in incognito mode
3. Check data/imported_leads.json exists
4. Check browser console for errors

---

## Advanced: Custom Enrichment

### Adding Business Intelligence

Integrate with OpenSalesClaw for enrichment:

```python
# In scraper_api.py
from opensalesclaw import enrich_lead

for lead in results['imported']:
    enriched = enrich_lead({
        'name': lead['name'],
        'phone': lead['phone'],
        'email': lead['email']
    })
    
    lead['enriched_data'] = {
        'estimated_revenue': enriched.get('revenue'),
        'decision_makers': enriched.get('contacts'),
        'social_profiles': enriched.get('social')
    }
```

### Adding Phone Validation

```python
from phone_validator import validate_phone

valid_phone = validate_phone(lead['phone'])
if not valid_phone:
    skip_lead("Invalid phone")
```

---

## Next Steps

1. ✅ Install dependencies
2. ✅ Configure search queries for your target market
3. ✅ Run first scrape
4. ✅ Import leads to dashboard
5. ✅ Review and prioritize
6. ✅ Start outreach
7. ✅ Track conversions
8. ✅ Optimize for best sources

---

## Performance Metrics

Track your scraper effectiveness:

```
Monthly Metrics:
├─ Businesses Scraped: 500-2000
├─ Leads Imported: 300-1500
├─ Deduplicated: 20-30%
├─ Quality Score (avg): 55-70
├─ Contacted: 30-50%
├─ Replied: 10-15%
├─ Qualified: 2-5%
└─ Closed: 1-3%
```

**Goals:**
- Week 1: Establish baseline
- Week 2-4: Optimize sources
- Month 2: Scale to new markets
- Month 3+: 5-10 deals/month

---

**Last Updated:** 2026-09-16  
**Version:** 1.0  
**Status:** Ready to Deploy
