# Quick Start Guide

## 🚀 Get Up and Running in 5 Minutes

### Prerequisites
✅ All 4 repositories cloned  
✅ Branch: `claude/open-all-repos-o32c0z`  
✅ Node.js/Python installed (depending on repos)

### Step 1: Verify Repos Are Ready

```bash
cd /home/user

# Check all repos exist
ls -la | grep -E "lead-pipeline|google-maps|scrapegraph|opensalesclaw"

# Expected output:
# drwxr-xr-x lead-pipeline
# drwxr-xr-x google-maps-scraper
# drwxr-xr-x scrapegraph-ai
# drwxr-xr-x opensalesclaw
```

### Step 2: Open the Lead Desk Dashboard

The punchlist interface is ready to use. Open it in any browser:

```bash
# From any repo directory
open lead-pipeline/punchlist-lead-desk.html
# or
open google-maps-scraper/punchlist-lead-desk.html
```

**Features Available**:
- 📋 **Board Tab**: View and manage leads
- ➕ **New Lead Tab**: Add leads manually
- 📊 **Numbers Tab**: View revenue analytics

### Step 3: Add a Test Lead

1. Click "New Lead" tab
2. Fill in the form:
   - Name: "Test Business"
   - Phone: "(555) 123-4567"
   - Email: "test@example.com"
   - City: "Dallas 75201"
   - Job: "Kitchen / bath remodel"
   - Budget: "$10k - $50k"
   - Timeline: "Within 2 weeks"
   - Property: "Owns the home"
3. Click "File the ticket"
4. See score calculated automatically
5. View in Board tab

### Step 4: Explore Your Lead

In the Board tab:
- 🔴 **Score**: 0-100 quality rating
- 🎯 **Action Buttons**: Move through pipeline
- 💰 **Price**: Suggested resale price
- 📊 **Tags**: Source, status, budget info

### Step 5: Track Revenue

Click "Numbers" tab to see:
- Lead sources performance
- Conversion rates
- Revenue by tier
- Pricing model

## 📁 Project Structure

```
/home/user/
├── lead-pipeline/                    # Lead management system
│   ├── punchlist-lead-desk.html     # Main dashboard
│   └── ...
├── google-maps-scraper/              # Business data collection
│   ├── punchlist-lead-desk.html
│   └── ...
├── scrapegraph-ai/                   # AI web scraping
│   ├── punchlist-lead-desk.html
│   └── ...
├── opensalesclaw/                    # Sales intelligence
│   ├── punchlist-lead-desk.html
│   └── ...
├── PROJECT_README.md                 # Full project overview
├── INTEGRATION_GUIDE.md               # Technical integration details
├── project-config.json               # Configuration file
└── QUICKSTART.md                     # This file
```

## 🔧 Common Tasks

### Navigate Between Repos

```bash
# Lead Pipeline
cd /home/user/lead-pipeline
git branch  # Verify on claude/open-all-repos-o32c0z

# Google Maps Scraper
cd /home/user/google-maps-scraper
git branch

# Scrapegraph AI
cd /home/user/scrapegraph-ai
git branch

# OpenSalesClaw
cd /home/user/opensalesclaw
git branch
```

### Check Changes on Branch

```bash
cd /home/user/lead-pipeline
git log --oneline -5
git status
```

### Make Changes on Designated Branch

```bash
# From any repo
git add .
git commit -m "Your change description"
git push -u origin claude/open-all-repos-o32c0z
```

## 💡 Dashboard Tips

### Lead Scoring

Scores combine:
- **Job Type** (5-20 pts): Kitchen remodel highest
- **Budget** (5-30 pts): Higher budget = more points
- **Timeline** (3-25 pts): ASAP = highest priority
- **Property Owner** (3-12 pts): Owner > Manager > Renter
- **Contact Info** (0-15 pts): Email + Phone = max
- **Scope Detail** (0-5 pts): More details = more points

### Color Coding

- 🔴 **Red Rail (70+)**: Hot lead - pursue immediately
- 🟡 **Gold Rail (45-69)**: Warm lead - follow up soon
- 🔵 **Blue Rail (0-44)**: Cold lead - nurture for later

### Export Data

1. Click "Export CSV" button
2. File downloads as `punchlist-leads.csv`
3. Open in Excel or Google Sheets
4. Share with team

## 🔗 Integration Status

| Repo | Status | Features | Branch |
|------|--------|----------|--------|
| lead-pipeline | ✅ Ready | Dashboard, scoring, tracking | claude/open-all-repos-o32c0z |
| google-maps-scraper | ✅ Ready | Data collection | claude/open-all-repos-o32c0z |
| scrapegraph-ai | ✅ Ready | AI scraping | claude/open-all-repos-o32c0z |
| opensalesclaw | ✅ Ready | Lead enrichment | claude/open-all-repos-o32c0z |

## 🎯 Next Steps

### Phase 1: Explore (Today)
- ✅ View each dashboard
- ✅ Create test leads
- ✅ Understand scoring
- ✅ Review analytics

### Phase 2: Integrate (This Week)
- Configure data pipelines
- Set up API connections
- Create import workflows
- Test end-to-end flow

### Phase 3: Deploy (Next Week)
- Set up production environment
- Configure monitoring
- Train team
- Go live

## 📚 Documentation

- **PROJECT_README.md**: Full project overview
- **INTEGRATION_GUIDE.md**: Technical integration details
- **project-config.json**: Configuration reference

## 🆘 Troubleshooting

### Dashboard Not Loading
- Clear browser cache
- Open in different browser
- Check file path is correct

### Storage Issues
- Dashboard stores data in browser's local storage
- Data persists across sessions
- Clear storage in browser dev tools to reset

### Export Issues
- Right-click "Export CSV" → "Save Link As"
- Check browser's downloads folder

## 📞 Support

All repositories on branch: `claude/open-all-repos-o32c0z`

For detailed technical information, see:
- `INTEGRATION_GUIDE.md` - Architecture & APIs
- `project-config.json` - Configuration reference

---

**Version**: 1.0  
**Updated**: 2026-09-16  
**Status**: 🟢 Ready to Use
