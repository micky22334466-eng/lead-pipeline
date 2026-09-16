# How to Run the Scraper Successfully - Complete Guide

This guide teaches you step-by-step how to run your handyman lead scraper system with confidence.

---

## 📋 Table of Contents

1. [Quick Start (5 minutes)](#quick-start)
2. [The Process Explained](#the-process)
3. [Real Scraping Workflow](#real-scraping)
4. [Customization Guide](#customization)
5. [Automation Setup](#automation)
6. [Troubleshooting](#troubleshooting)
7. [Success Checklist](#checklist)

---

## Quick Start

### What You'll Do (5 minutes)

1. Navigate to the project folder
2. Run the quick import test
3. View results in the dashboard

### Commands to Run

```bash
# Step 1: Go to the project directory
cd /home/user/lead-pipeline

# Step 2: Run the test with example data
python quick_import.py

# Step 3: Open the dashboard in your browser
# File: /home/user/lead-pipeline/punchlist-lead-desk.html
```

### Expected Result

- ✅ Script prints "10 leads imported successfully"
- ✅ File `data/imported_leads.json` is created
- ✅ Dashboard shows 10 handyman businesses
- ✅ Each lead has a color score (red/gold/blue)

### What Just Happened?

1. **Loaded** 10 example handyman businesses from JSON
2. **Transformed** them to lead format (business → lead)
3. **Validated** each lead (checked phone, email, fields)
4. **Scored** each lead (0-100 based on quality)
5. **Saved** to dashboard storage
6. **Displayed** in the dashboard interface

---

## The Process Explained

### Before vs. After

#### INPUT: Raw scraped business

```json
{
  "business_name": "ABC Handyman Services",
  "phone": "(214) 555-0101",
  "address": "123 Main St, Dallas, TX 75201",
  "rating": 4.8,
  "review_count": 87,
  "email": "info@abchandyman.com",
  "category": "Handyman Services",
  "website": "abchandyman.com"
}
```

#### OUTPUT: Dashboard-ready lead

```json
{
  "name": "ABC Handyman Services",
  "phone": "(214) 555-0101",
  "email": "info@abchandyman.com",
  "city": "Dallas, TX",
  "job": "multi",           # Auto-detected from category
  "budget": "c",            # Estimated from rating & reviews
  "timeline": "plan",       # Assumed planning stage
  "source": "Google Maps",
  "scope": "Handyman Services - 4.8 rated, 87 reviews",
  "status": "New",
  "at": "2026-09-16T15:30:00",
  "score": 75,              # Calculated by dashboard
  "confidence_bonus": 12    # Points from quality factors
}
```

### The Transformation Happens Here

```
Raw Business Data
      ↓
[scraper_integration.py]
      ↓
  Transform:
    • Extract city from address
    • Map category → job type
    • Estimate budget
    • Create scope description
      ↓
  Validate:
    • Phone format check
    • Email format check
    • Required fields check
    • Quality threshold check
      ↓
  Deduplicate:
    • Check existing phone/email
    • Check name+city combination
      ↓
  Score:
    • Calculate confidence bonus
    • Points for contact info
    • Points for ratings
      ↓
[scraper_api.py]
      ↓
  Save to data/imported_leads.json
      ↓
Dashboard Ready
```

### Service Type Auto-Detection

The system automatically knows which job type each business is:

```
Category → Job Type Mapping:
  Handyman Services      → multi (multi-trade repair)
  Plumbing Services      → single (single repair)
  Electrical Services    → single (single repair)
  HVAC Services          → single (single repair)
  Roofing Services       → multi (multi-trade repair)
  Kitchen Remodeling     → remodel (full remodel)
  Bathroom Remodeling    → remodel (full remodel)
  Flooring Installation  → single (single repair)
  Painting Services      → single (single repair)
  Drywall Services       → single (single repair)
```

### Budget Auto-Estimation

Formula: `(rating × 10) + (reviews ÷ 5)`

**Example 1: Established, high-rated**
- Rating: 4.8, Reviews: 87
- Calculation: (4.8 × 10) + (87 ÷ 5) = 48 + 17 = 65
- Result: Budget "c" ($2500-5000 projects)

**Example 2: Newer, lower rating**
- Rating: 3.5, Reviews: 15
- Calculation: (3.5 × 10) + (15 ÷ 5) = 35 + 3 = 38
- Result: Budget "b" ($500-2500 projects)

---

## Real Scraping Workflow

### Step 1: Get Scraper Running

You have two options:

#### Option A: Use Google Maps Scraper Desktop App (Easiest)

```
1. Go to: /home/user/google-maps-scraper
2. Download and install the desktop app
3. Open the application
4. Enter:
   - Search query: "handyman near me"
   - Location: "Dallas, TX"
   - Max results: 500
5. Click "Run" and wait (5-30 minutes)
6. Export results as JSON
7. Save to: /home/user/lead-pipeline/scraped_businesses.json
```

#### Option B: Use Python API

```python
from botasaurus_api import api

result = api.get_google_maps_data(
    queries=["handyman near me"],
    locations=["Dallas, TX"],
    max_results=500
)

import json
with open("scraped_businesses.json", "w") as f:
    json.dump(result, f)
```

### Step 2: Import the Scraped Data

```bash
cd /home/user/lead-pipeline
python scraper_api.py
```

This command:
1. Reads `scraped_businesses.json`
2. Transforms each business (200+ lines of processing)
3. Validates phone/email format
4. Checks against existing leads (deduplication)
5. Calculates confidence scores
6. Saves to `data/imported_leads.json`
7. Logs the import in `data/import_log.json`

### Step 3: See Results in Dashboard

```
Open: /home/user/lead-pipeline/punchlist-lead-desk.html

Click: "Board" tab
See: Your imported businesses as leads
Filter: By status or source
Sort: By score (highest first)
```

### Expected Volumes

Per scraping session:

| Metric | Expected Range |
|--------|-----------------|
| Businesses scraped | 200-500 |
| Leads qualified | 150-400 |
| Deduplicated (removed) | 20-30% |
| Ready to import | 100-300 |
| Average score | 55-75 |
| Hot leads (70+) | 20-30% |

---

## Customization Guide

### Where to Make Changes

**File:** `scraper_config.py`

### 1. Change Target Cities

**Find this:**
```python
TARGET_LOCATIONS = [
    "Dallas, TX",
    "Houston, TX",
]
```

**Change to:**
```python
TARGET_LOCATIONS = [
    "Your City, TX",
    "Another City, TX",
    "More Cities, TX",
]
```

### 2. Adjust Quality Standards

**For high-quality leads only:**
```python
QUALITY_FILTERS = {
    "min_rating": 4.5,      # Only top-rated
    "min_reviews": 50,      # Established businesses
}
```

**For volume (include newer):**
```python
QUALITY_FILTERS = {
    "min_rating": 3.0,      # More inclusive
    "min_reviews": 3,       # Less stringent
}
```

**For balanced approach:**
```python
QUALITY_FILTERS = {
    "min_rating": 3.5,      # Mid-range
    "min_reviews": 5,       # Some history
}
```

### 3. Select Which Services to Include

**Currently active 10 service types.**

To focus on specific services only:
1. Open `scraper_config.py`
2. Comment out unwanted services in `HANDYMAN_SEARCH_QUERIES`
3. Keep only the ones you want

Example: Focus only on handyman and plumbing:
```python
HANDYMAN_SEARCH_QUERIES = {
    "general_handyman": { ... },
    "plumbing": { ... },
    # All others commented out
}
```

### 4. Budget Categories Reference

The system assigns budgets as:
- **a** = Under $500
- **b** = $500-2,500
- **c** = $2,500-5,000
- **d** = $5,000-10,000
- **e** = $10,000+

You can customize in config:
```python
"handyman": {
    "min_budget": "b",     # Start at $500+
    "max_budget": "d",     # End at $10k
}
```

---

## Automation Setup

### Run Every Day At 9 AM

```bash
# Open the cron editor
crontab -e

# Add this line:
0 9 * * * cd /home/user/lead-pipeline && python scraper_api.py
```

### Run Multiple Times Per Day

```bash
# 9 AM, 2 PM, and 6 PM
0 9,14,18 * * * cd /home/user/lead-pipeline && python scraper_api.py
```

### Verify It's Working

```bash
# List your scheduled jobs
crontab -l

# Check the import log for results
cat data/import_log.json
```

### What Gets Logged

Each import creates an entry in `data/import_log.json`:

```json
{
  "timestamp": "2026-09-16T09:00:00",
  "total_processed": 500,
  "imported": 350,
  "duplicates_skipped": 100,
  "failed_validation": 50,
  "average_score": 65
}
```

---

## Troubleshooting

### Problem: "No leads imported"

**Check 1: File exists?**
```bash
ls -la scraped_businesses.json
```

**Check 2: File has data?**
```bash
head -20 scraped_businesses.json
```

**Check 3: Quality filters too strict?**
- Edit `scraper_config.py`
- Change `min_rating: 3.5` to `3.0`
- Change `min_reviews: 5` to `3`

**Check 4: Required fields present?**
File must have these fields for each business:
- `business_name`
- `phone`
- `address`
- `rating`
- `review_count`
- `category`

### Problem: "Lots of duplicates"

**Cause:** Importing same data multiple times

**Solutions:**
1. Delete already imported leads:
   ```bash
   rm data/imported_leads.json
   ```

2. Scrape different cities:
   ```python
   TARGET_LOCATIONS = ["New City, TX", "Another City, TX"]
   ```

3. Check import log to see what's done:
   ```bash
   cat data/import_log.json
   ```

### Problem: "Dashboard not showing new leads"

**Solution 1: Clear browser cache**
- Ctrl+Shift+Delete in browser
- Clear all browsing data
- Reload page

**Solution 2: Open in incognito mode**
- Ctrl+Shift+N (Chrome)
- Ctrl+Shift+P (Firefox)

**Solution 3: Verify data file exists**
```bash
cat data/imported_leads.json | head -5
```

### Problem: "Python script errors"

**Check Python version:**
```bash
python --version
# Need 3.7 or higher
```

**Install missing packages:**
```bash
pip install flask
```

**Check for syntax errors:**
```bash
python -m py_compile scraper_config.py
python -m py_compile scraper_integration.py
```

---

## Complete Workflow - Day by Day

### Monday: Initial Scrape

```
9:00 AM
  - Set up Google Maps scraper
  - Configure target city (e.g., Dallas, TX)
  - Start scraping (wait 10-30 minutes)

10:30 AM
  - Scraper finishes
  - Export results as scraped_businesses.json
  - Run: python scraper_api.py
  - Monitor: data/import_log.json

11:00 AM
  - Open dashboard
  - Review imported leads
  - Sort by score (highest first)
  - Count hot leads (70+)

Expected Result: 200-300 leads, 40-50 hot
```

### Tuesday-Wednesday: Initial Outreach

```
Morning
  - Dashboard: Filter hot leads (70+)
  - Create contact list
  - Prepare outreach message

Afternoon
  - Call businesses (15-20 calls/day)
  - Or send messages
  - Update status to "Contacted"
  - Record interest level

Evening
  - Review responses
  - Move interested to "Quoted"

Expected Result: 20% response rate (~8-10 leads)
```

### Thursday: Qualification

```
Morning
  - Follow up with interested leads
  - Qualify opportunities
  - Understand their needs

Afternoon
  - Create proposals
  - Move to "Quoted" status
  - Send estimates

Expected Result: 3-5 qualified opportunities
```

### Friday: Analysis & Planning

```
Morning
  - Check import log statistics
  - Review conversion rates
  - Identify best sources

Afternoon
  - Plan next week scrapes
  - Update configuration if needed
  - Prepare new search areas

Weekly Results:
  - 250+ leads imported
  - 50+ hot leads
  - 20+ contacted
  - 5+ interested
  - 1-3 closed deals
```

---

## Command Reference

### Most Important Commands

**Test with example data (safe test):**
```bash
cd /home/user/lead-pipeline && python quick_import.py
```

**Import real scraped data:**
```bash
cd /home/user/lead-pipeline && python scraper_api.py
```

**View what was imported:**
```bash
cat /home/user/lead-pipeline/data/imported_leads.json | head -20
```

**Check import history:**
```bash
cat /home/user/lead-pipeline/data/import_log.json
```

**View configuration:**
```bash
cat /home/user/lead-pipeline/scraper_config.py
```

**Check Python version:**
```bash
python --version
```

**Install required packages:**
```bash
pip install flask
```

**Schedule daily import:**
```bash
crontab -e
# Add: 0 9 * * * cd /home/user/lead-pipeline && python scraper_api.py
```

---

## Success Checklist

### Before You Start

- [ ] You have Python 3.7+ installed
- [ ] You have internet connection
- [ ] You can access /home/user/lead-pipeline directory
- [ ] Flask is installed (`pip install flask`)

### First Time Running

- [ ] Run `python quick_import.py` successfully
- [ ] See "10 leads imported" message
- [ ] Dashboard opens in browser
- [ ] See 10 handyman businesses in Board tab
- [ ] Each lead has a color score

### First Real Scrape

- [ ] Google Maps scraper is running
- [ ] Scraper completes without errors
- [ ] Save results as scraped_businesses.json
- [ ] Run `python scraper_api.py`
- [ ] See successful import message
- [ ] Check data/imported_leads.json created
- [ ] Dashboard shows new leads

### Optimization

- [ ] Set up cron for daily 9 AM import
- [ ] Check crontab -l to verify
- [ ] Monitor data/import_log.json weekly
- [ ] Adjust configuration based on results
- [ ] Expand to 2-3 cities in one month
- [ ] Close first 5-10 deals in month 1

---

## Expected Timeline

### Day 1 (Today)
- Install everything
- Test with example data
- Review dashboard

### Day 2-3
- Set up Google Maps scraper
- Run first real scrape
- Import and review leads

### Week 1
- Contact hot leads
- Record responses
- Follow up

### Week 2-4
- Qualify opportunities
- Send proposals
- Close initial deals

### Month 2+
- Expand to new markets
- Automate daily scraping
- Scale to 50+ deals/month

---

## Numbers to Expect

### Per Scraping Session
- 200-500 businesses scraped
- 150-400 qualified by filters
- 20-30% duplicates removed
- 100-300 final imports
- Average score: 55-75

### Score Distribution
- Red (70+): 20-30% of leads
- Gold (45-69): 40-50% of leads
- Blue (<45): 20-30% of leads

### Conversion Flow
- Scraped → Imported: 85%
- Imported → Contacted: 50%
- Contacted → Interested: 25%
- Interested → Qualified: 40%
- Qualified → Closed: 30%

### Monthly Results
- Month 1: 1,000 leads, 5-10 deals
- Month 2: 2,000 leads, 20-30 deals
- Month 3: 3,000 leads, 40-60 deals

---

## You're Ready! 

When you get your PC, follow these steps:

```bash
# 1. Test the system
cd /home/user/lead-pipeline
python quick_import.py

# 2. Open dashboard
# File: /home/user/lead-pipeline/punchlist-lead-desk.html

# 3. Set up Google Maps scraper
# Read: /home/user/google-maps-scraper/README.md

# 4. Run first real import
python scraper_api.py

# 5. Start contacting leads
# Use the dashboard to manage your pipeline
```

---

**Document Created:** 2026-09-16  
**Status:** Ready to Use  
**Questions?** Check SCRAPER_SETUP_GUIDE.md or COMPLETE_SYSTEM_MAP.md
