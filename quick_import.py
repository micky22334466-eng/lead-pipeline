#!/usr/bin/env python
"""
Quick Start: Import Example Leads
Run this script to import example businesses into the lead pipeline
"""

import json
import sys
from scraper_api import LeadImportAPI

def main():
    print("\n" + "="*60)
    print("  HANDYMAN LEAD SCRAPER - QUICK IMPORT")
    print("="*60 + "\n")

    # Initialize API
    api = LeadImportAPI()
    print("✓ API initialized")

    # Load example businesses
    try:
        with open("example_scraped_businesses.json", "r") as f:
            businesses = json.load(f)
        print(f"✓ Loaded {len(businesses)} example businesses")
    except FileNotFoundError:
        print("✗ example_scraped_businesses.json not found")
        print("  Create it with: cp example_scraped_businesses.json scraped_businesses.json")
        sys.exit(1)

    # Import leads
    print("\nImporting leads...")
    result = api.import_leads(businesses)

    # Print report
    print("\n" + api.integration.generate_import_report(result['data']))

    # Show imported leads
    if result['data']['imported']:
        print("\n✅ IMPORTED LEADS PREVIEW\n")
        print(f"{'Name':<40} {'Phone':<15} {'Job Type':<12}")
        print("-" * 67)

        for lead in result['data']['imported'][:5]:
            name = lead['name'][:39]
            phone = lead['phone'][:14]
            job = lead['job']
            print(f"{name:<40} {phone:<15} {job:<12}")

        if len(result['data']['imported']) > 5:
            print(f"... and {len(result['data']['imported']) - 5} more")

    # Next steps
    print("\n" + "="*60)
    print("📋 NEXT STEPS")
    print("="*60)
    print("\n1. Open the dashboard:")
    print("   → /home/user/lead-pipeline/punchlist-lead-desk.html")
    print("\n2. Click 'Board' tab to see imported leads")
    print("\n3. Filter by:")
    print("   • Status: New")
    print("   • Source: Google Maps")
    print("\n4. Review leads by score:")
    print("   • Red (70+):   Contact today")
    print("   • Gold (45-69): Follow up this week")
    print("   • Blue (<45):  Nurture for later")
    print("\n5. Start outreach!")
    print("\n" + "="*60 + "\n")

    # Status summary
    print(f"Summary: {result['data']['imported']} leads ready to work")
    print(f"Storage: data/imported_leads.json")
    print(f"Status: {result['message']}\n")

    return 0 if result['success'] else 1


if __name__ == "__main__":
    sys.exit(main())
