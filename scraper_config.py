"""
Scraper Configuration for Handyman & Home Improvement Leads
Designed to work with Google Maps Scraper and Scrapegraph AI
"""

# ============================================================================
# HANDYMAN BUSINESS SEARCH QUERIES
# ============================================================================

HANDYMAN_SEARCH_QUERIES = {
    "general_handyman": {
        "queries": [
            "handyman near me",
            "handyman services",
            "general contractor",
            "home repair"
        ],
        "job_type": "multi",  # Multi-trade repair
        "min_budget": "b",  # $500-2k
        "max_budget": "d"   # $10k-50k
    },

    "plumbing": {
        "queries": [
            "plumber near me",
            "plumbing services",
            "emergency plumber"
        ],
        "job_type": "single",  # Single repair
        "min_budget": "a",  # Under $500
        "max_budget": "c"   # $2k-10k
    },

    "electrical": {
        "queries": [
            "electrician near me",
            "electrical services",
            "licensed electrician"
        ],
        "job_type": "single",
        "min_budget": "a",
        "max_budget": "c"
    },

    "hvac": {
        "queries": [
            "HVAC near me",
            "air conditioning services",
            "heating services"
        ],
        "job_type": "single",
        "min_budget": "b",
        "max_budget": "d"
    },

    "roofing": {
        "queries": [
            "roofer near me",
            "roofing services",
            "roof repair"
        ],
        "job_type": "multi",
        "min_budget": "c",
        "max_budget": "e"
    },

    "kitchen_remodel": {
        "queries": [
            "kitchen remodeling",
            "kitchen renovation",
            "kitchen cabinet installation"
        ],
        "job_type": "remodel",
        "min_budget": "d",
        "max_budget": "e"
    },

    "bathroom_remodel": {
        "queries": [
            "bathroom remodeling",
            "bath renovation",
            "bathroom tile installation"
        ],
        "job_type": "remodel",
        "min_budget": "c",
        "max_budget": "e"
    },

    "flooring": {
        "queries": [
            "flooring installation",
            "hardwood floor installation",
            "tile flooring services"
        ],
        "job_type": "single",
        "min_budget": "b",
        "max_budget": "d"
    },

    "painting": {
        "queries": [
            "house painter near me",
            "interior painting",
            "exterior painting services"
        ],
        "job_type": "single",
        "min_budget": "a",
        "max_budget": "b"
    },

    "drywall": {
        "queries": [
            "drywall repair",
            "drywall installation",
            "drywall finishing"
        ],
        "job_type": "single",
        "min_budget": "a",
        "max_budget": "b"
    }
}

# ============================================================================
# TARGET LOCATIONS (Cities/Areas)
# ============================================================================

TARGET_LOCATIONS = [
    "Dallas, TX",
    "Houston, TX",
    "Austin, TX",
    "San Antonio, TX",
    "Fort Worth, TX",
    "Arlington, TX",
    "Plano, TX",
    # Add more locations as needed
]

# ============================================================================
# SCRAPER DATA FIELDS TO EXTRACT
# ============================================================================

REQUIRED_FIELDS = {
    "business_name": "Company name",
    "phone": "Phone number",
    "website": "Website URL",
    "address": "Business address",
    "rating": "Google rating",
    "review_count": "Number of reviews",
    "email": "Business email (if available)",
    "hours": "Business hours",
    "category": "Business category"
}

# ============================================================================
# LEAD SCORING ADJUSTMENTS FOR SCRAPED DATA
# ============================================================================

SCRAPER_CONFIDENCE_SCORING = {
    "has_phone": 3,          # +3 points if phone scraped
    "has_website": 2,        # +2 points if website found
    "high_rating": 5,        # +5 points if rating >= 4.5
    "many_reviews": 4,       # +4 points if 100+ reviews
    "recent_activity": 3,    # +3 points if active in last month
    "verified_email": 4      # +4 points if email verified
}

# ============================================================================
# DATA ENRICHMENT CONFIG
# ============================================================================

ENRICHMENT_CONFIG = {
    "enabled": True,
    "enrich_emails": True,
    "enrich_social": True,
    "enrich_decision_makers": True,
    "enrich_revenue_estimate": True
}

# ============================================================================
# IMPORT SETTINGS
# ============================================================================

IMPORT_CONFIG = {
    "batch_size": 50,           # Import 50 leads at a time
    "deduplicate": True,        # Remove duplicate phone/email
    "validate_phones": True,    # Validate phone format
    "validate_emails": True,    # Validate email format
    "auto_qualify": True,       # Auto-qualify based on data
    "set_source": "Google Maps", # Set lead source
    "set_timeline": "plan",     # Most scraped leads are planning
    "set_owner": "own"          # Assume property owner
}

# ============================================================================
# SCRAPING INTERVALS
# ============================================================================

SCRAPING_SCHEDULE = {
    "daily": {
        "enabled": True,
        "time": "09:00",  # 9 AM daily
        "queries_per_day": 2  # Run 2 different search queries
    },

    "weekly": {
        "enabled": True,
        "day": "Monday",
        "time": "08:00",  # Monday 8 AM
        "queries": ["general handyman", "plumber near me", "electrician near me"]
    },

    "monthly": {
        "enabled": True,
        "day": "1st",
        "time": "07:00",  # 1st of month at 7 AM
        "queries": "ALL"  # Run all search queries
    }
}

# ============================================================================
# API ENDPOINTS
# ============================================================================

API_ENDPOINTS = {
    "import_leads": "/api/leads/import",
    "enrich_leads": "/api/enrich",
    "score_leads": "/api/leads/score",
    "export_leads": "/api/leads/export"
}

# ============================================================================
# RATE LIMITING & THROTTLING
# ============================================================================

RATE_LIMITING = {
    "google_maps": {
        "requests_per_day": 100,  # Google Maps has limits
        "delay_between_requests": 2  # seconds
    },
    "import_api": {
        "requests_per_minute": 30,
        "batch_delay": 1  # second between batches
    }
}

# ============================================================================
# LOGGING & MONITORING
# ============================================================================

LOGGING_CONFIG = {
    "log_file": "scraper_logs/handyman_scraper.log",
    "log_level": "INFO",
    "log_api_calls": True,
    "log_errors": True,
    "log_imports": True
}

# ============================================================================
# QUALITY FILTERS
# ============================================================================

QUALITY_FILTERS = {
    "min_rating": 3.5,           # Only businesses rated 3.5+
    "min_reviews": 5,            # At least 5 reviews
    "require_phone": True,       # Must have phone number
    "require_website": False,    # Website preferred but not required
    "exclude_keywords": [        # Exclude these types
        "furniture",
        "retail",
        "dealership",
        "bank",
        "school"
    ]
}

# ============================================================================
# HANDYMAN SERVICE MAPPING
# ============================================================================

SERVICE_TO_JOB_TYPE = {
    "handyman": "multi",
    "general contractor": "multi",
    "plumber": "single",
    "electrician": "single",
    "painter": "single",
    "roofer": "multi",
    "hvac": "single",
    "drywall": "single",
    "flooring": "single",
    "kitchen": "remodel",
    "bathroom": "remodel",
    "renovation": "remodel",
    "remodeling": "remodel"
}

if __name__ == "__main__":
    print("Handyman Scraper Configuration Loaded")
    print(f"Total Search Queries: {sum(len(v['queries']) for v in HANDYMAN_SEARCH_QUERIES.values())}")
    print(f"Target Locations: {len(TARGET_LOCATIONS)}")
    print(f"Service Categories: {len(SERVICE_TO_JOB_TYPE)}")
