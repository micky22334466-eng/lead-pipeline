"""
Lead Import API Server
Provides HTTP endpoints for importing scraped leads into the pipeline

Usage:
    python scraper_api.py

Endpoints:
    POST /api/leads/import - Import a batch of leads
    GET /api/leads/status - Check import status
    GET /api/health - Health check
"""

import json
import os
from datetime import datetime
from typing import Dict, List
from scraper_integration import HandymanScraperIntegration

# Simple file-based storage (no database needed)
LEADS_FILE = "data/imported_leads.json"
IMPORT_LOG_FILE = "data/import_log.json"

class LeadImportAPI:
    """Simple API for lead imports"""

    def __init__(self):
        self.integration = HandymanScraperIntegration()
        self._ensure_data_dirs()
        self.existing_leads = self._load_existing_leads()

    def _ensure_data_dirs(self):
        """Create data directories if they don't exist"""
        os.makedirs("data", exist_ok=True)

    def _load_existing_leads(self) -> List[Dict]:
        """Load existing leads from file"""
        if os.path.exists(LEADS_FILE):
            try:
                with open(LEADS_FILE, 'r') as f:
                    return json.load(f)
            except:
                return []
        return []

    def _save_leads(self, leads: List[Dict]):
        """Save leads to file"""
        with open(LEADS_FILE, 'w') as f:
            json.dump(leads, f, indent=2)

    def _save_import_log(self, log_entry: Dict):
        """Append to import log"""
        logs = []
        if os.path.exists(IMPORT_LOG_FILE):
            try:
                with open(IMPORT_LOG_FILE, 'r') as f:
                    logs = json.load(f)
            except:
                logs = []

        logs.append(log_entry)

        with open(IMPORT_LOG_FILE, 'w') as f:
            json.dump(logs, f, indent=2)

    def import_leads(self, scraped_businesses: List[Dict]) -> Dict:
        """
        Import a batch of scraped businesses as leads

        Args:
            scraped_businesses: List of businesses from scraper

        Returns:
            {
                "success": bool,
                "message": str,
                "data": {
                    "imported": int,
                    "skipped": int,
                    "failed": int,
                    "total": int,
                    "leads": [...]
                }
            }
        """

        try:
            # Process batch
            results = self.integration.import_leads_batch(
                scraped_businesses,
                self.existing_leads
            )

            # Save imported leads
            self.existing_leads.extend(results["imported"])
            self._save_leads(self.existing_leads)

            # Log import
            log_entry = {
                "timestamp": datetime.now().isoformat(),
                "imported": len(results["imported"]),
                "skipped": len(results["skipped"]),
                "failed": len(results["failed"]),
                "total": results["total"],
                "status": "success"
            }
            self._save_import_log(log_entry)

            return {
                "success": True,
                "message": f"Imported {len(results['imported'])} leads successfully",
                "data": {
                    "imported": len(results["imported"]),
                    "skipped": len(results["skipped"]),
                    "failed": len(results["failed"]),
                    "total": results["total"],
                    "leads": results["imported"]
                }
            }

        except Exception as e:
            log_entry = {
                "timestamp": datetime.now().isoformat(),
                "status": "error",
                "error": str(e)
            }
            self._save_import_log(log_entry)

            return {
                "success": False,
                "message": f"Import failed: {str(e)}",
                "data": None
            }

    def get_status(self) -> Dict:
        """Get import status and statistics"""

        try:
            logs = []
            if os.path.exists(IMPORT_LOG_FILE):
                with open(IMPORT_LOG_FILE, 'r') as f:
                    logs = json.load(f)

            total_imported = sum(log.get("imported", 0) for log in logs)
            total_leads = len(self.existing_leads)
            last_import = logs[-1] if logs else None

            return {
                "success": True,
                "data": {
                    "total_leads": total_leads,
                    "total_imported": total_imported,
                    "last_import": last_import,
                    "import_count": len(logs)
                }
            }

        except Exception as e:
            return {
                "success": False,
                "message": str(e),
                "data": None
            }

    def export_for_dashboard(self) -> List[Dict]:
        """
        Export leads in dashboard format for punchlist-lead-desk.html

        Converts stored format to dashboard lead format
        """

        dashboard_leads = []

        for idx, lead in enumerate(self.existing_leads, 1):
            dashboard_lead = {
                "n": idx,
                "name": lead.get("name"),
                "phone": lead.get("phone"),
                "email": lead.get("email"),
                "city": lead.get("city"),
                "job": lead.get("job"),
                "budget": lead.get("budget"),
                "timeline": lead.get("timeline"),
                "owner": lead.get("owner"),
                "source": lead.get("source"),
                "scope": lead.get("scope"),
                "status": lead.get("status", "New"),
                "route": lead.get("route"),
                "sold": lead.get("sold"),
                "at": lead.get("imported_at", datetime.now().isoformat())
            }
            dashboard_leads.append(dashboard_lead)

        return dashboard_leads


# Flask app (optional - can be used as standalone)
try:
    from flask import Flask, request, jsonify

    app = Flask(__name__)
    api = LeadImportAPI()

    @app.route('/health', methods=['GET'])
    def health():
        """Health check endpoint"""
        return jsonify({
            "status": "healthy",
            "timestamp": datetime.now().isoformat()
        })

    @app.route('/api/leads/import', methods=['POST'])
    def import_leads_endpoint():
        """
        Import scraped leads

        Request body:
        {
            "businesses": [
                {
                    "business_name": "...",
                    "phone": "...",
                    "email": "...",
                    "address": "...",
                    "category": "...",
                    "rating": 4.5,
                    "review_count": 30
                }
            ]
        }
        """

        try:
            data = request.get_json()
            businesses = data.get("businesses", [])

            if not businesses:
                return jsonify({
                    "success": False,
                    "message": "No businesses provided"
                }), 400

            result = api.import_leads(businesses)
            status_code = 200 if result["success"] else 400

            return jsonify(result), status_code

        except Exception as e:
            return jsonify({
                "success": False,
                "message": str(e)
            }), 500

    @app.route('/api/leads/status', methods=['GET'])
    def status_endpoint():
        """Get import status"""
        return jsonify(api.get_status())

    @app.route('/api/leads/export', methods=['GET'])
    def export_endpoint():
        """Export all leads in dashboard format"""
        leads = api.export_for_dashboard()
        return jsonify({
            "success": True,
            "count": len(leads),
            "leads": leads
        })

    if __name__ == '__main__':
        print("Starting Lead Import API Server...")
        print("Endpoints:")
        print("  POST /api/leads/import - Import scraped leads")
        print("  GET /api/leads/status - Check import status")
        print("  GET /api/leads/export - Export leads for dashboard")
        print("  GET /health - Health check")
        print("\nServer running on http://localhost:5000")

        app.run(debug=True, port=5000)

except ImportError:
    print("Flask not installed. Using file-based API only.")
    print("Install with: pip install flask")

    # Standalone usage
    if __name__ == '__main__':
        api = LeadImportAPI()

        # Example: Import leads from file
        example_file = "scraped_businesses.json"

        if os.path.exists(example_file):
            with open(example_file, 'r') as f:
                businesses = json.load(f)

            result = api.import_leads(businesses)
            print(json.dumps(result, indent=2))
        else:
            print(f"No {example_file} found. Create one with scraped business data.")
