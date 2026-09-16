# Integration Guide - Lead Pipeline & Sales Intelligence Platform

## Overview

This guide outlines how to integrate the 4 repositories into a cohesive lead management and sales intelligence platform.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     Lead Desk Dashboard                          │
│              (punchlist-lead-desk.html)                         │
│  - Lead intake & management                                     │
│  - Pipeline tracking                                            │
│  - Analytics & revenue reporting                                │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│                    Lead Pipeline System                          │
│              (lead-pipeline repository)                         │
│  - Lead storage & management                                    │
│  - Status tracking                                              │
│  - Scoring calculation                                          │
│  - Data validation                                              │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│              Sales Intelligence & Enrichment                     │
│              (opensalesclaw repository)                         │
│  - Lead data enrichment                                         │
│  - Company intelligence                                         │
│  - Intent scoring                                               │
│  - CRM integration                                              │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│              Web Scraping & Data Collection                      │
│  ┌────────────────────────┬────────────────────────────────┐   │
│  │ Google Maps Scraper    │    Scrapegraph AI              │   │
│  │ - Location data        │ - Content extraction           │   │
│  │ - Reviews & ratings    │ - Multi-source scraping        │   │
│  │ - Business info        │ - AI-powered parsing           │   │
│  └────────────────────────┴────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────┘
```

## Integration Points

### 1. Data Collection → Enrichment

**From**: google-maps-scraper / scrapegraph-ai  
**To**: opensalesclaw

**Data Transfer Format**:
```json
{
  "business_name": "string",
  "location": "string",
  "phone": "string",
  "website": "string",
  "industry": "string",
  "ratings": "number",
  "review_count": "number",
  "extracted_data": "object"
}
```

**API/Method**: 
- REST API endpoint or
- File-based import (JSON/CSV)

### 2. Enrichment → Lead Pipeline

**From**: opensalesclaw  
**To**: lead-pipeline

**Data Transfer Format**:
```json
{
  "name": "string",
  "phone": "string",
  "email": "string",
  "city": "string",
  "job": "string",
  "budget": "string",
  "timeline": "string",
  "owner": "string",
  "source": "string",
  "scope": "string",
  "status": "New|Contacted|Quoted|Won|Dead",
  "enriched_data": {
    "company_name": "string",
    "industry": "string",
    "intent_score": "number",
    "recommendation": "string"
  }
}
```

### 3. Lead Pipeline → Dashboard

**From**: lead-pipeline  
**To**: punchlist-lead-desk.html

**Data Transfer**:
- Local storage synchronization
- Real-time dashboard updates
- CSV export functionality

## Setup Instructions

### Phase 1: Repository Initialization

```bash
# All repos should be cloned and on the correct branch
cd /home/user
ls -la  # Verify all repos present

# Verify branches
cd lead-pipeline && git branch
cd ../google-maps-scraper && git branch
cd ../scrapegraph-ai && git branch
cd ../opensalesclaw && git branch
```

### Phase 2: Dependency Setup

For each repository, install dependencies as needed:

```bash
# Lead Pipeline (if Node/Python based)
cd /home/user/lead-pipeline
npm install  # or pip install -r requirements.txt

# Google Maps Scraper
cd /home/user/google-maps-scraper
pip install -r requirements.txt  # or npm install

# Scrapegraph AI
cd /home/user/scrapegraph-ai
pip install -r requirements.txt  # or npm install

# OpenSalesClaw
cd /home/user/opensalesclaw
npm install  # or pip install -r requirements.txt
```

### Phase 3: API Configuration

Create `.env` files or configuration files in each repo:

**lead-pipeline/.env**:
```
ENRICHMENT_API_URL=http://localhost:3001/api/enrich
STORAGE_TYPE=local  # or cloud
```

**opensalesclaw/.env**:
```
SCRAPER_API_URL=http://localhost:3000/api/extract
PIPELINE_API_URL=http://localhost:3002/api/leads
```

**google-maps-scraper/.env**:
```
GOOGLE_MAPS_API_KEY=your_api_key
OUTPUT_API_URL=http://localhost:3001/api/import
```

**scrapegraph-ai/.env**:
```
SCRAPE_API_KEY=your_api_key
OUTPUT_API_URL=http://localhost:3001/api/import
```

### Phase 4: Data Pipeline Configuration

Create `pipeline-config.json` in root:

```json
{
  "stages": [
    {
      "name": "collection",
      "repos": ["google-maps-scraper", "scrapegraph-ai"],
      "output": "/data/raw_leads.json"
    },
    {
      "name": "enrichment",
      "repo": "opensalesclaw",
      "input": "/data/raw_leads.json",
      "output": "/data/enriched_leads.json"
    },
    {
      "name": "import",
      "repo": "lead-pipeline",
      "input": "/data/enriched_leads.json",
      "action": "import_leads"
    }
  ]
}
```

## Data Flow Examples

### Example 1: Lead Generation from Google Maps Scrape

```
1. Google Maps Scraper extracts business data
   ↓
2. Data formatted to lead template
   ↓
3. Sent to OpenSalesClaw for enrichment
   ↓
4. Enriched lead imported to lead-pipeline
   ↓
5. Displayed in punchlist dashboard
```

### Example 2: Scoring & Prioritization

```
Raw Lead:
{
  "name": "ABC Construction",
  "phone": "(555) 123-4567",
  "city": "Dallas TX",
  "job": "Kitchen Remodel"
}
      ↓
Enriched by OpenSalesClaw:
{
  "...original fields...",
  "budget": "c" (2k-10k),
  "timeline": "month",
  "owner": "own",
  "score": 68
}
      ↓
Pipeline calculates final score: 68
      ↓
Dashboard shows as "WARM" lead
```

## API Specifications

### Lead Import API

**Endpoint**: `POST /api/leads/import`

**Request Body**:
```json
{
  "leads": [
    {
      "name": "string",
      "phone": "string",
      "email": "string",
      "city": "string",
      "job": "string",
      "budget": "string",
      "timeline": "string",
      "owner": "string",
      "source": "string",
      "scope": "string"
    }
  ],
  "batch_id": "string",
  "source": "string"
}
```

**Response**:
```json
{
  "success": true,
  "imported": 10,
  "failed": 0,
  "lead_ids": ["WO-0001", "WO-0002", ...]
}
```

### Lead Enrichment API

**Endpoint**: `POST /api/enrich`

**Request Body**:
```json
{
  "business_data": {
    "name": "string",
    "location": "string",
    "contact": "string"
  }
}
```

**Response**:
```json
{
  "enriched_fields": {
    "industry": "string",
    "estimated_revenue": "string",
    "intent_score": 0-100,
    "recommendation": "string"
  }
}
```

## Testing Integration

### Unit Testing
- Test each repo independently
- Verify data format compliance
- Validate score calculations

### Integration Testing
```bash
# Test data flow from scraper to pipeline
./test-flow.sh

# Test enrichment accuracy
./test-enrichment.sh

# Test dashboard functionality
./test-dashboard.sh
```

### End-to-End Testing
1. Create test lead via scraper
2. Enrich through opensalesclaw
3. Import to lead-pipeline
4. Verify in dashboard
5. Check score calculation

## Deployment Steps

1. **Dev Environment**: Test on local branches
2. **Staging**: Deploy to staging servers
3. **Production**: Deploy to production with monitoring
4. **Monitoring**: Set up alerts for data flow issues

## Common Issues & Solutions

### Issue 1: Data Format Mismatch
**Solution**: Validate data against schema in `project-config.json`

### Issue 2: Scoring Inconsistency
**Solution**: Ensure all repos use same scoring algorithm

### Issue 3: API Connection Errors
**Solution**: Check `.env` files and API endpoint availability

## Maintenance

- Monitor data pipeline health
- Update API keys regularly
- Review and update scoring model
- Backup lead data weekly
- Monitor scraper success rates

## Next Steps

1. ✅ Clone all repositories
2. ✅ Set up branch coordination
3. → Configure API connections
4. → Implement data pipelines
5. → Set up automated imports
6. → Deploy dashboard
7. → Configure monitoring
8. → Train team on system

---

**Last Updated**: 2026-09-16  
**Version**: 1.0.0  
**Branch**: `claude/open-all-repos-o32c0z`
