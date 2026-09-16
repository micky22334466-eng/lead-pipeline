"""
Handyman Lead Scraper Integration
Integrates Google Maps Scraper and Scrapegraph AI with Lead Pipeline

This module:
1. Fetches scraped business data
2. Enriches with intelligence
3. Imports into lead pipeline dashboard
4. Tracks import status
"""

import json
import re
from datetime import datetime
from typing import List, Dict, Tuple
from scraper_config import (
    SERVICE_TO_JOB_TYPE,
    IMPORT_CONFIG,
    SCRAPER_CONFIDENCE_SCORING,
    QUALITY_FILTERS,
    ENRICHMENT_CONFIG
)

class HandymanScraperIntegration:
    """
    Manages integration between scrapers and lead pipeline
    """

    def __init__(self):
        self.imported_count = 0
        self.failed_count = 0
        self.skipped_count = 0
        self.import_log = []

    # ========================================================================
    # DATA TRANSFORMATION
    # ========================================================================

    def transform_scraped_data(self, scraped_business: Dict) -> Dict:
        """
        Transform Google Maps scraped business data into lead format

        Input: {
            "business_name": "ABC Handyman",
            "phone": "(555) 123-4567",
            "website": "abchandyman.com",
            "address": "123 Main St, Dallas TX",
            "rating": 4.8,
            "review_count": 45,
            "email": "info@abchandyman.com",
            "category": "Handyman Services"
        }

        Output: {
            "name": "ABC Handyman",
            "phone": "(555) 123-4567",
            "email": "info@abchandyman.com",
            "city": "Dallas TX",
            "job": "multi",
            "budget": "b",
            "timeline": "plan",
            "owner": "own",
            "source": "Google Maps",
            "scope": "Professional handyman services",
            "status": "New",
            "route": null,
            "sold": null
        }
        """

        try:
            # Extract city from address
            city = self._extract_city(scraped_business.get("address", ""))

            # Determine job type from business category
            job_type = self._map_category_to_job(scraped_business.get("category", ""))

            # Estimate budget range from rating and reviews
            budget = self._estimate_budget(
                scraped_business.get("rating", 3),
                scraped_business.get("review_count", 0)
            )

            # Create scope description
            scope = self._create_scope(scraped_business)

            lead = {
                "name": scraped_business.get("business_name", "Unknown"),
                "phone": scraped_business.get("phone", ""),
                "email": scraped_business.get("email", ""),
                "city": city,
                "job": job_type,
                "budget": budget,
                "timeline": "plan",  # Scraped leads are in planning stage
                "owner": "own",      # Assume business owner
                "source": "Google Maps",
                "scope": scope,
                "status": "New",
                "route": None,
                "sold": None,
                "metadata": {
                    "rating": scraped_business.get("rating"),
                    "review_count": scraped_business.get("review_count"),
                    "website": scraped_business.get("website"),
                    "hours": scraped_business.get("hours")
                }
            }

            return lead

        except Exception as e:
            print(f"Error transforming data: {e}")
            return None

    def _extract_city(self, address: str) -> str:
        """Extract city from address"""
        if not address:
            return ""

        parts = address.split(",")
        if len(parts) >= 2:
            return ",".join(parts[-2:]).strip()  # City, State
        return address.strip()

    def _map_category_to_job(self, category: str) -> str:
        """Map business category to job type"""
        category_lower = category.lower()

        for service_keyword, job_type in SERVICE_TO_JOB_TYPE.items():
            if service_keyword in category_lower:
                return job_type

        # Default to multi-trade if category unclear
        return "multi"

    def _estimate_budget(self, rating: float, review_count: int) -> str:
        """
        Estimate budget range based on business quality metrics

        Higher rating + more reviews = likely higher budget projects
        """

        # Score based on metrics
        quality_score = (rating * 10) + min(review_count / 5, 20)

        if quality_score < 40:
            return "a"  # Under $500
        elif quality_score < 60:
            return "b"  # $500-2k
        elif quality_score < 80:
            return "c"  # $2k-10k
        elif quality_score < 95:
            return "d"  # $10k-50k
        else:
            return "e"  # $50k+

    def _create_scope(self, business: Dict) -> str:
        """Create scope description from business data"""

        name = business.get("business_name", "Service provider")
        category = business.get("category", "home services")
        rating = business.get("rating", "")
        reviews = business.get("review_count", "")

        scope = f"Professional {category.lower()} provider"

        if rating:
            scope += f" (${rating} rating"
            if reviews:
                scope += f", {reviews} reviews"
            scope += ")"

        return scope

    # ========================================================================
    # VALIDATION & QUALITY CHECKS
    # ========================================================================

    def validate_lead(self, lead: Dict) -> Tuple[bool, str]:
        """
        Validate lead meets quality requirements

        Returns: (is_valid, reason_if_invalid)
        """

        # Check required fields
        if not lead.get("name"):
            return False, "Missing business name"

        if not lead.get("phone") and not lead.get("email"):
            return False, "Missing phone and email"

        # Check quality filters
        metadata = lead.get("metadata", {})
        rating = metadata.get("rating", 0)
        reviews = metadata.get("review_count", 0)

        if rating < QUALITY_FILTERS["min_rating"]:
            return False, f"Rating too low: {rating}"

        if reviews < QUALITY_FILTERS["min_reviews"]:
            return False, f"Too few reviews: {reviews}"

        # Check excluded keywords
        name_lower = lead.get("name", "").lower()
        for excluded in QUALITY_FILTERS["exclude_keywords"]:
            if excluded in name_lower:
                return False, f"Excluded keyword: {excluded}"

        return True, ""

    def validate_phone(self, phone: str) -> bool:
        """Validate phone number format"""
        if not phone:
            return False

        # Remove common formatting
        clean_phone = re.sub(r"\D", "", phone)
        return len(clean_phone) >= 10

    def validate_email(self, email: str) -> bool:
        """Validate email format"""
        if not email:
            return False

        pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
        return re.match(pattern, email) is not None

    # ========================================================================
    # IMPORT & DEDUPLICATION
    # ========================================================================

    def deduplicate_lead(self, lead: Dict, existing_leads: List[Dict]) -> bool:
        """
        Check if lead already exists in system

        Checks by: phone number, email, or name + city combo
        """

        if not IMPORT_CONFIG["deduplicate"]:
            return False  # No duplicate found

        phone = lead.get("phone", "").replace("-", "").replace(" ", "")
        email = lead.get("email", "").lower()
        name = lead.get("name", "").lower()
        city = lead.get("city", "").lower()

        for existing in existing_leads:
            existing_phone = existing.get("phone", "").replace("-", "").replace(" ", "")
            existing_email = existing.get("email", "").lower()
            existing_name = existing.get("name", "").lower()
            existing_city = existing.get("city", "").lower()

            # Check phone match
            if phone and existing_phone and phone == existing_phone:
                return True

            # Check email match
            if email and existing_email and email == existing_email:
                return True

            # Check name + city match
            if name and city and existing_name and existing_city:
                if name == existing_name and city == existing_city:
                    return True

        return False

    # ========================================================================
    # CONFIDENCE SCORING
    # ========================================================================

    def calculate_confidence_score(self, lead: Dict) -> int:
        """
        Calculate confidence bonus points for scraped lead
        Adds to automatic scoring
        """

        confidence_bonus = 0
        metadata = lead.get("metadata", {})

        # Has phone
        if lead.get("phone"):
            confidence_bonus += SCRAPER_CONFIDENCE_SCORING["has_phone"]

        # Has website
        if metadata.get("website"):
            confidence_bonus += SCRAPER_CONFIDENCE_SCORING["has_website"]

        # High rating (4.5+)
        if metadata.get("rating", 0) >= 4.5:
            confidence_bonus += SCRAPER_CONFIDENCE_SCORING["high_rating"]

        # Many reviews (100+)
        if metadata.get("review_count", 0) >= 100:
            confidence_bonus += SCRAPER_CONFIDENCE_SCORING["many_reviews"]

        # Verified email
        if lead.get("email") and self.validate_email(lead.get("email")):
            confidence_bonus += SCRAPER_CONFIDENCE_SCORING["verified_email"]

        return min(confidence_bonus, 20)  # Max 20 point bonus

    # ========================================================================
    # BATCH IMPORT
    # ========================================================================

    def import_leads_batch(self,
                           scraped_businesses: List[Dict],
                           existing_leads: List[Dict] = None) -> Dict:
        """
        Import a batch of scraped leads into pipeline

        Returns summary: {
            "imported": count,
            "failed": count,
            "skipped": count,
            "total": count,
            "details": [...]
        }
        """

        if existing_leads is None:
            existing_leads = []

        results = {
            "imported": [],
            "failed": [],
            "skipped": [],
            "total": len(scraped_businesses)
        }

        for business in scraped_businesses:
            try:
                # Transform to lead format
                lead = self.transform_scraped_data(business)

                if not lead:
                    results["failed"].append({
                        "business": business,
                        "reason": "Transform failed"
                    })
                    continue

                # Validate quality
                is_valid, reason = self.validate_lead(lead)

                if not is_valid:
                    results["skipped"].append({
                        "business": business,
                        "reason": reason
                    })
                    continue

                # Check for duplicates
                if self.deduplicate_lead(lead, existing_leads):
                    results["skipped"].append({
                        "business": business,
                        "reason": "Duplicate lead"
                    })
                    continue

                # Add confidence score bonus
                confidence_bonus = self.calculate_confidence_score(lead)
                lead["confidence_bonus"] = confidence_bonus

                # Add timestamp
                lead["imported_at"] = datetime.now().isoformat()

                # Mark for import
                results["imported"].append(lead)
                existing_leads.append(lead)  # Add to existing for dedup

            except Exception as e:
                results["failed"].append({
                    "business": business,
                    "reason": str(e)
                })

        return results

    # ========================================================================
    # REPORTING
    # ========================================================================

    def generate_import_report(self, results: Dict) -> str:
        """Generate human-readable import report"""

        report = f"""
╔══════════════════════════════════════════════════════════════╗
║         HANDYMAN SCRAPER IMPORT REPORT                      ║
╚══════════════════════════════════════════════════════════════╝

📊 SUMMARY
────────────────────────────────────────────────────────────────
Total Businesses Processed: {results['total']}
✅ Successfully Imported:    {len(results['imported'])}
❌ Failed:                   {len(results['failed'])}
⏭️  Skipped:                 {len(results['skipped'])}

📈 IMPORT RATE
────────────────────────────────────────────────────────────────
Success Rate:               {len(results['imported']) / results['total'] * 100:.1f}%
Skipped Rate:               {len(results['skipped']) / results['total'] * 100:.1f}%

🎯 READY FOR PIPELINE
────────────────────────────────────────────────────────────────
New leads ready to manage in dashboard:
→ {len(results['imported'])} leads

These leads are set as:
  • Status: New
  • Timeline: Planning stage
  • Source: Google Maps
  • Job Types: Multi, Single, or Remodel
  • Budgets: Auto-estimated

🔍 TOP SKIP REASONS
────────────────────────────────────────────────────────────────
        """

        skip_reasons = {}
        for skip in results['skipped']:
            reason = skip['reason']
            skip_reasons[reason] = skip_reasons.get(reason, 0) + 1

        for reason, count in sorted(skip_reasons.items(), key=lambda x: x[1], reverse=True)[:5]:
            report += f"\n  • {reason}: {count}"

        report += "\n\n✨ NEXT STEPS\n"
        report += "────────────────────────────────────────────────────────────────\n"
        report += "1. Open punchlist-lead-desk.html\n"
        report += "2. Check 'Board' tab for new leads\n"
        report += "3. Filter by 'New' status\n"
        report += "4. Start reaching out to hot leads (score 70+)\n"
        report += "\n" + "="*62 + "\n"

        return report


def example_usage():
    """Example of how to use the scraper integration"""

    # Initialize integration
    integration = HandymanScraperIntegration()

    # Example scraped businesses from Google Maps
    scraped_businesses = [
        {
            "business_name": "ABC Handyman Services",
            "phone": "(555) 123-4567",
            "website": "abchandyman.com",
            "address": "123 Main St, Dallas TX 75201",
            "rating": 4.8,
            "review_count": 45,
            "email": "info@abchandyman.com",
            "category": "Handyman Services",
            "hours": "Mon-Fri 8AM-6PM"
        },
        {
            "business_name": "Dallas Plumbing Pro",
            "phone": "(555) 987-6543",
            "website": "dallasp lumbing.com",
            "address": "456 Oak Ave, Dallas TX 75202",
            "rating": 4.6,
            "review_count": 78,
            "email": "contact@dallasplumbing.com",
            "category": "Plumbing Services",
            "hours": "24/7 Emergency"
        }
    ]

    # Import batch
    results = integration.import_leads_batch(scraped_businesses)

    # Print report
    print(integration.generate_import_report(results))

    # Get imported leads
    for lead in results['imported']:
        print(f"\n✓ {lead['name']} ({lead['city']})")
        print(f"  Phone: {lead['phone']}")
        print(f"  Job Type: {lead['job']}")
        print(f"  Budget: {lead['budget']}")


if __name__ == "__main__":
    example_usage()
