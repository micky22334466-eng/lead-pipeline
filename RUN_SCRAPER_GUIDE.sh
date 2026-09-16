#!/bin/bash

################################################################################
#                                                                              #
#  HANDYMAN LEAD SCRAPER - COMPLETE EXECUTION GUIDE                           #
#  A step-by-step tutorial to run the scraper integration successfully        #
#                                                                              #
#  This script teaches you how to:                                            #
#  1. Test the system with example data                                       #
#  2. Run a real Google Maps scrape                                           #
#  3. Import leads into the dashboard                                         #
#  4. View and manage leads                                                   #
#  5. Automate daily scraping                                                 #
#  6. Monitor your leads                                                      #
#                                                                              #
################################################################################

clear

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║   HANDYMAN LEAD SCRAPER - EXECUTION GUIDE                      ║"
echo "║   Learn how to run your lead generation system                 ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

################################################################################
# SECTION 1: BEFORE YOU START
################################################################################

show_section_1() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 1: BEFORE YOU START${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo "REQUIREMENTS:"
    echo "  ✓ Python 3.7 or higher installed"
    echo "  ✓ /home/user/lead-pipeline directory available"
    echo "  ✓ Flask installed (pip install flask)"
    echo "  ✓ Internet connection for scraping"
    echo ""

    echo "FILE STRUCTURE NEEDED:"
    echo "  lead-pipeline/"
    echo "  ├── scraper_config.py          ← Configuration settings"
    echo "  ├── scraper_integration.py     ← Transform & validate logic"
    echo "  ├── scraper_api.py             ← Import API"
    echo "  ├── quick_import.py            ← Quick test script"
    echo "  ├── example_scraped_businesses.json  ← Example data"
    echo "  ├── punchlist-lead-desk.html   ← Dashboard"
    echo "  └── data/"
    echo "      ├── imported_leads.json    ← Stored leads"
    echo "      └── import_log.json        ← Import history"
    echo ""

    read -p "Press Enter to continue to SECTION 2..."
}

################################################################################
# SECTION 2: QUICK TEST (5 MINUTES)
################################################################################

show_section_2() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 2: QUICK TEST WITH EXAMPLE DATA (5 MINUTES)${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo "This section shows you how to test the system with pre-built example data."
    echo ""

    echo -e "${YELLOW}STEP 1: Navigate to the project directory${NC}"
    echo "  Command:"
    echo "    ${GREEN}cd /home/user/lead-pipeline${NC}"
    echo ""
    echo "  What it does: Changes to your scraper directory"
    echo ""

    echo -e "${YELLOW}STEP 2: Run the quick import test${NC}"
    echo "  Command:"
    echo "    ${GREEN}python quick_import.py${NC}"
    echo ""
    echo "  What it does:"
    echo "    • Loads 10 example handyman businesses"
    echo "    • Transforms them to lead format"
    echo "    • Validates each lead"
    echo "    • Calculates confidence scores"
    echo "    • Saves to data/imported_leads.json"
    echo ""
    echo "  Expected output:"
    echo "    ✓ API initialized"
    echo "    ✓ Loaded 10 example businesses"
    echo "    ✓ Importing leads..."
    echo "    → 10 leads imported successfully"
    echo "    → [Report showing statistics]"
    echo ""
    echo "  Success indicators:"
    echo "    • No errors displayed"
    echo "    • All 10 leads imported"
    echo "    • data/imported_leads.json file created/updated"
    echo ""

    read -p "Press Enter to continue to SECTION 3..."
}

################################################################################
# SECTION 3: VIEW IN DASHBOARD
################################################################################

show_section_3() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 3: VIEW LEADS IN DASHBOARD (2 MINUTES)${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo "Now let's see your imported leads in the interactive dashboard."
    echo ""

    echo -e "${YELLOW}STEP 1: Open the dashboard${NC}"
    echo "  File path:"
    echo "    ${GREEN}/home/user/lead-pipeline/punchlist-lead-desk.html${NC}"
    echo ""
    echo "  How to open:"
    echo "    • Double-click the file in file explorer"
    echo "    • Or right-click → Open with → Your browser"
    echo "    • Or: file:///home/user/lead-pipeline/punchlist-lead-desk.html"
    echo ""

    echo -e "${YELLOW}STEP 2: View your imported leads${NC}"
    echo "  Instructions:"
    echo "    1. Click the 'Board' tab at the top"
    echo "    2. You should see 10 leads in a table"
    echo "    3. Each has:"
    echo "       • Name (business name)"
    echo "       • Phone"
    echo "       • Source: Google Maps"
    echo "       • Status: New"
    echo "       • Score (0-100, color-coded)"
    echo ""

    echo -e "${YELLOW}STEP 3: Understand the lead scoring${NC}"
    echo "  Color coding:"
    echo "    🔴 Red (70+):     Hot leads - contact TODAY"
    echo "    🟡 Gold (45-69):  Warm leads - follow up this week"
    echo "    🔵 Blue (<45):    Cold leads - nurture for later"
    echo ""
    echo "  Score factors:"
    echo "    • Business rating (4.5+ = +5 points)"
    echo "    • Review count (100+ = +4 points)"
    echo "    • Has phone number (+3 points)"
    echo "    • Has website (+2 points)"
    echo "    • Email verified (+4 points)"
    echo ""

    echo -e "${YELLOW}STEP 4: Interact with leads${NC}"
    echo "  You can:"
    echo "    • Click a lead row to see details"
    echo "    • Change status (New → Contacted → Quoted → Won)"
    echo "    • Update revenue tracking"
    echo "    • Filter by status or source"
    echo "    • Export to CSV"
    echo ""

    read -p "Press Enter to continue to SECTION 4..."
}

################################################################################
# SECTION 4: REAL GOOGLE MAPS SCRAPE
################################################################################

show_section_4() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 4: RUN A REAL GOOGLE MAPS SCRAPE${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo "This section shows how to scrape REAL handyman businesses from Google Maps."
    echo ""

    echo -e "${YELLOW}STEP 1: Get the Google Maps Scraper${NC}"
    echo "  You have this repo: /home/user/google-maps-scraper"
    echo ""
    echo "  Options to scrape:"
    echo ""
    echo "  Option A: Use the Desktop App (Easiest)"
    echo "    1. Download from: google-maps-scraper repository"
    echo "    2. Install on your computer"
    echo "    3. Open the app"
    echo "    4. Enter search query: 'handyman near me'"
    echo "    5. Enter location: 'Dallas, TX' (or your city)"
    echo "    6. Click 'Run'"
    echo "    7. Wait for scraping (5-30 minutes depending on volume)"
    echo "    8. Export results as JSON"
    echo ""
    echo "  Option B: Use the Python API"
    echo "    Command:"
    echo "      ${GREEN}from botasaurus_api import api${NC}"
    echo "      ${GREEN}result = api.get_google_maps_data(${NC}"
    echo "      ${GREEN}    queries=['handyman near me'],${NC}"
    echo "      ${GREEN}    locations=['Dallas, TX'],${NC}"
    echo "      ${GREEN}    max_results=500${NC}"
    echo "      ${GREEN})${NC}"
    echo ""

    echo -e "${YELLOW}STEP 2: Prepare the scraped data${NC}"
    echo "  File location:"
    echo "    ${GREEN}/home/user/lead-pipeline/scraped_businesses.json${NC}"
    echo ""
    echo "  Expected format:"
    echo "    ["
    echo "      {"
    echo "        \"business_name\": \"ABC Handyman\","
    echo "        \"phone\": \"(555) 123-4567\","
    echo "        \"website\": \"abchandyman.com\","
    echo "        \"address\": \"123 Main St, Dallas TX\","
    echo "        \"rating\": 4.8,"
    echo "        \"review_count\": 87,"
    echo "        \"email\": \"info@abchandyman.com\","
    echo "        \"category\": \"Handyman Services\""
    echo "      }"
    echo "    ]"
    echo ""

    echo -e "${YELLOW}STEP 3: Import the scraped businesses${NC}"
    echo "  Command:"
    echo "    ${GREEN}cd /home/user/lead-pipeline${NC}"
    echo "    ${GREEN}python scraper_api.py${NC}"
    echo ""
    echo "  What happens:"
    echo "    1. Reads scraped_businesses.json"
    echo "    2. Transforms each business to lead format"
    echo "    3. Auto-detects job type (handyman→multi, plumber→single, etc.)"
    echo "    4. Estimates budget based on rating & reviews"
    echo "    5. Validates phone/email format"
    echo "    6. Removes duplicates"
    echo "    7. Calculates confidence score"
    echo "    8. Saves to data/imported_leads.json"
    echo ""
    echo "  Expected output:"
    echo "    Total processed: 500"
    echo "    Successfully imported: 350"
    echo "    Duplicates skipped: 100"
    echo "    Failed validation: 50"
    echo ""

    read -p "Press Enter to continue to SECTION 5..."
}

################################################################################
# SECTION 5: UNDERSTANDING THE TRANSFORMATION
################################################################################

show_section_5() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 5: HOW THE TRANSFORMATION WORKS${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo "Understand what happens to your scraped data internally."
    echo ""

    echo -e "${YELLOW}INPUT: Raw scraped business${NC}"
    echo "  {"
    echo "    \"business_name\": \"Dallas Plumbing Pros\","
    echo "    \"phone\": \"(214) 555-0102\","
    echo "    \"address\": \"456 Oak Ave, Dallas, TX 75202\","
    echo "    \"rating\": 4.6,"
    echo "    \"review_count\": 142,"
    echo "    \"category\": \"Plumbing Services\""
    echo "  }"
    echo ""

    echo -e "${YELLOW}TRANSFORMATION STEPS:${NC}"
    echo ""
    echo "  Step 1: Extract city from address"
    echo "    Input:  \"456 Oak Ave, Dallas, TX 75202\""
    echo "    Output: \"Dallas, TX\""
    echo ""

    echo "  Step 2: Map category to job type"
    echo "    Input:  \"Plumbing Services\""
    echo "    Output: \"single\" (from SERVICE_TO_JOB_TYPE mapping)"
    echo ""

    echo "  Step 3: Estimate budget"
    echo "    Formula: rating*10 + reviews/5"
    echo "    Calc: (4.6 * 10) + (142 / 5) = 46 + 28 = 74"
    echo "    Output: \"c\" (tier for $5k-10k jobs)"
    echo ""

    echo "  Step 4: Create scope description"
    echo "    Output: \"Plumbing Services - 4.6 rated, 142 reviews\""
    echo ""

    echo "  Step 5: Validate data"
    echo "    Check: Phone format valid? ✓"
    echo "    Check: Email format valid? ✓"
    echo "    Check: Required fields present? ✓"
    echo ""

    echo "  Step 6: Calculate confidence score"
    echo "    Has phone? +3 pts"
    echo "    Rating 4.5+? +5 pts"
    echo "    100+ reviews? +4 pts"
    echo "    Total bonus: 12 points"
    echo ""

    echo -e "${YELLOW}OUTPUT: Dashboard-ready lead${NC}"
    echo "  {"
    echo "    \"name\": \"Dallas Plumbing Pros\","
    echo "    \"phone\": \"(214) 555-0102\","
    echo "    \"city\": \"Dallas, TX\","
    echo "    \"job\": \"single\","
    echo "    \"budget\": \"c\","
    echo "    \"timeline\": \"plan\","
    echo "    \"source\": \"Google Maps\","
    echo "    \"scope\": \"Plumbing Services\","
    echo "    \"status\": \"New\","
    echo "    \"confidence_bonus\": 12"
    echo "  }"
    echo ""

    echo -e "${YELLOW}DASHBOARD SCORE CALCULATION:${NC}"
    echo "  Base score: 55 (avg for quality business)"
    echo "  + Confidence bonus: 12"
    echo "  = Total score: 67"
    echo "  = Color: 🟡 Gold (warm lead)"
    echo ""

    read -p "Press Enter to continue to SECTION 6..."
}

################################################################################
# SECTION 6: CUSTOMIZING THE CONFIG
################################################################################

show_section_6() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 6: CUSTOMIZE YOUR CONFIGURATION${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo "Learn how to customize the scraper for your specific needs."
    echo ""

    echo -e "${YELLOW}CONFIGURATION FILE: scraper_config.py${NC}"
    echo ""

    echo "1. CHANGE TARGET CITIES"
    echo "   Find this section:"
    echo "     ${GREEN}TARGET_LOCATIONS = [${NC}"
    echo "     ${GREEN}    \"Dallas, TX\",${NC}"
    echo "     ${GREEN}    \"Houston, TX\",${NC}"
    echo "     ${GREEN}]${NC}"
    echo ""
    echo "   Change to your cities:"
    echo "     ${GREEN}TARGET_LOCATIONS = [${NC}"
    echo "     ${GREEN}    \"Your City, TX\",${NC}"
    echo "     ${GREEN}    \"Another City, TX\",${NC}"
    echo "     ${GREEN}]${NC}"
    echo ""

    echo "2. ADJUST QUALITY FILTERS"
    echo "   For HIGH-QUALITY leads only:"
    echo "     ${GREEN}QUALITY_FILTERS = {${NC}"
    echo "     ${GREEN}    \"min_rating\": 4.5,${NC}"
    echo "     ${GREEN}    \"min_reviews\": 50,${NC}"
    echo "     ${GREEN}}${NC}"
    echo ""
    echo "   For VOLUME (include newer businesses):"
    echo "     ${GREEN}QUALITY_FILTERS = {${NC}"
    echo "     ${GREEN}    \"min_rating\": 3.0,${NC}"
    echo "     ${GREEN}    \"min_reviews\": 3,${NC}"
    echo "     ${GREEN}}${NC}"
    echo ""

    echo "3. WHICH SERVICE TYPES TO INCLUDE"
    echo "   Current services in HANDYMAN_SEARCH_QUERIES:"
    echo "     • general_handyman → multi-trade repair"
    echo "     • plumbing → single repair"
    echo "     • electrical → single repair"
    echo "     • hvac → single repair"
    echo "     • roofing → multi-trade repair"
    echo "     • kitchen → remodeling"
    echo "     • bathroom → remodeling"
    echo "     • flooring → single repair"
    echo "     • painting → single repair"
    echo "     • drywall → single repair"
    echo ""
    echo "   To add a new service:"
    echo "     ${GREEN}\"your_service\": {${NC}"
    echo "     ${GREEN}    \"queries\": [\"your service near me\"],${NC}"
    echo "     ${GREEN}    \"job_type\": \"multi\",${NC}"
    echo "     ${GREEN}    \"min_budget\": \"a\",${NC}"
    echo "     ${GREEN}    \"max_budget\": \"d\"${NC}"
    echo "     ${GREEN}}${NC}"
    echo ""

    echo "4. BUDGET CATEGORIES"
    echo "   a = Under \$500"
    echo "   b = \$500-2500"
    echo "   c = \$2500-5000"
    echo "   d = \$5000-10000"
    echo "   e = \$10000+"
    echo ""

    read -p "Press Enter to continue to SECTION 7..."
}

################################################################################
# SECTION 7: AUTOMATE DAILY SCRAPING
################################################################################

show_section_7() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 7: AUTOMATE DAILY SCRAPING WITH CRON${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo "Set up automatic daily scraping so you get fresh leads every day."
    echo ""

    echo -e "${YELLOW}STEP 1: Open crontab editor${NC}"
    echo "  Command:"
    echo "    ${GREEN}crontab -e${NC}"
    echo ""
    echo "  This opens a text editor where you can schedule commands."
    echo ""

    echo -e "${YELLOW}STEP 2: Add a scheduled job${NC}"
    echo "  Add this line to run import every day at 9 AM:"
    echo "    ${GREEN}0 9 * * * cd /home/user/lead-pipeline && python scraper_api.py${NC}"
    echo ""
    echo "  Explanation:"
    echo "    0       = minute (0)"
    echo "    9       = hour (9 AM)"
    echo "    *       = day of month (any)"
    echo "    *       = month (any)"
    echo "    *       = day of week (any)"
    echo "    rest    = command to run"
    echo ""

    echo "  For multiple times per day:"
    echo "    ${GREEN}0 9,14,18 * * * cd /home/user/lead-pipeline && python scraper_api.py${NC}"
    echo "    (Runs at 9 AM, 2 PM, and 6 PM)"
    echo ""

    echo -e "${YELLOW}STEP 3: Save and exit${NC}"
    echo "  • Press Ctrl+O to save"
    echo "  • Press Enter to confirm"
    echo "  • Press Ctrl+X to exit"
    echo ""

    echo -e "${YELLOW}STEP 4: Verify it's scheduled${NC}"
    echo "  Command:"
    echo "    ${GREEN}crontab -l${NC}"
    echo ""
    echo "  You should see your scheduled job listed."
    echo ""

    echo -e "${YELLOW}STEP 5: Check logs${NC}"
    echo "  Your imports will be logged in:"
    echo "    ${GREEN}data/import_log.json${NC}"
    echo ""
    echo "  Each entry shows:"
    echo "    • timestamp of import"
    echo "    • number of leads imported"
    echo "    • number of duplicates"
    echo "    • number of validation failures"
    echo ""

    read -p "Press Enter to continue to SECTION 8..."
}

################################################################################
# SECTION 8: MONITOR AND OPTIMIZE
################################################################################

show_section_8() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 8: MONITOR AND OPTIMIZE YOUR SYSTEM${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${YELLOW}CHECK IMPORT STATUS${NC}"
    echo "  Command (if Flask server running):"
    echo "    ${GREEN}curl http://localhost:5000/api/leads/status${NC}"
    echo ""
    echo "  Response shows:"
    echo "    • total_leads imported"
    echo "    • last_import timestamp"
    echo "    • import_count (how many times you've imported)"
    echo ""

    echo -e "${YELLOW}REVIEW IMPORT LOG${NC}"
    echo "  File:"
    echo "    ${GREEN}data/import_log.json${NC}"
    echo ""
    echo "  Shows:"
    echo "    • Each import operation"
    echo "    • Timestamp"
    echo "    • Statistics (imported, duplicates, failed)"
    echo ""

    echo -e "${YELLOW}OPTIMIZE BASED ON METRICS${NC}"
    echo ""
    echo "  Metric: Too many duplicates (>30%)"
    echo "  Action: Expand to new cities in TARGET_LOCATIONS"
    echo ""
    echo "  Metric: Too few leads imported (<100)"
    echo "  Action: Lower min_rating and min_reviews in QUALITY_FILTERS"
    echo ""
    echo "  Metric: Poor lead quality (avg score <50)"
    echo "  Action: Increase min_rating and min_reviews"
    echo ""
    echo "  Metric: Not enough hot leads (>50 red/score 70+)"
    echo "  Action: Focus on high-review businesses by increasing min_reviews"
    echo ""

    echo -e "${YELLOW}TRACK WEEKLY PERFORMANCE${NC}"
    echo "  Each week, record:"
    echo "    • Leads imported"
    echo "    • Average score"
    echo "    • Hot leads (70+)"
    echo "    • Contacts attempted"
    echo "    • Response rate"
    echo "    • Qualified opportunities"
    echo ""
    echo "  Expected Week 1:"
    echo "    • ~250 leads imported"
    echo "    • ~60 average score"
    echo "    • ~40 hot leads"
    echo ""

    read -p "Press Enter to continue to SECTION 9..."
}

################################################################################
# SECTION 9: TROUBLESHOOTING
################################################################################

show_section_9() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 9: TROUBLESHOOTING COMMON ISSUES${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${RED}PROBLEM: No leads imported${NC}"
    echo "  Cause 1: scraped_businesses.json not found"
    echo "    Solution: Make sure file exists in /home/user/lead-pipeline/"
    echo ""
    echo "  Cause 2: Quality filters too strict"
    echo "    Solution: Lower min_rating to 3.0 and min_reviews to 3"
    echo ""
    echo "  Cause 3: Wrong data format"
    echo "    Solution: Check file has required fields:"
    echo "      business_name, phone, address, rating, review_count, category"
    echo ""

    echo -e "${RED}PROBLEM: Lots of duplicates (>50%)${NC}"
    echo "  Cause: Importing same data multiple times"
    echo "    Solution: Check import log to see what's already imported"
    echo "    Or: Scrape different cities"
    echo ""

    echo -e "${RED}PROBLEM: Dashboard not showing new leads${NC}"
    echo "  Solution 1: Clear browser cache"
    echo "    • Press Ctrl+Shift+Delete in browser"
    echo "    • Clear all browsing data"
    echo ""
    echo "  Solution 2: Open in incognito mode"
    echo "    • Ctrl+Shift+N (Chrome) or Ctrl+Shift+P (Firefox)"
    echo ""
    echo "  Solution 3: Check data file exists"
    echo "    ${GREEN}ls -la data/imported_leads.json${NC}"
    echo ""

    echo -e "${RED}PROBLEM: Python script errors${NC}"
    echo "  Solution 1: Check Python version"
    echo "    ${GREEN}python --version${NC}"
    echo "    (Need 3.7 or higher)"
    echo ""
    echo "  Solution 2: Install missing packages"
    echo "    ${GREEN}pip install flask${NC}"
    echo ""
    echo "  Solution 3: Check syntax in config"
    echo "    ${GREEN}python -m py_compile scraper_config.py${NC}"
    echo ""

    read -p "Press Enter to continue to SECTION 10..."
}

################################################################################
# SECTION 10: COMPLETE WORKFLOW EXAMPLE
################################################################################

show_section_10() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 10: COMPLETE WORKFLOW - DAY BY DAY${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${YELLOW}MONDAY 9:00 AM${NC}"
    echo "  Task: Run first scrape of the week"
    echo "  Commands:"
    echo "    ${GREEN}cd /home/user/lead-pipeline${NC}"
    echo "    ${GREEN}python scraper_api.py${NC}"
    echo "  Result: 200-300 new leads imported"
    echo ""

    echo -e "${YELLOW}MONDAY 10:00 AM${NC}"
    echo "  Task: Review leads in dashboard"
    echo "  Steps:"
    echo "    1. Open punchlist-lead-desk.html"
    echo "    2. Click 'Board' tab"
    echo "    3. Sort by score (highest first)"
    echo "    4. Filter to hot leads (70+)"
    echo "  Result: See ~40-50 leads to contact"
    echo ""

    echo -e "${YELLOW}MONDAY 11:00 AM - 5:00 PM${NC}"
    echo "  Task: Contact hot leads"
    echo "  Steps:"
    echo "    1. Click each red lead in dashboard"
    echo "    2. Note phone number"
    echo "    3. Make call or send message"
    echo "    4. Update status in dashboard (New → Contacted)"
    echo "    5. Record response"
    echo "  Goal: Contact 20-30 leads"
    echo ""

    echo -e "${YELLOW}TUESDAY-THURSDAY${NC}"
    echo "  Task: Follow up with interested leads"
    echo "  Steps:"
    echo "    1. Move promising leads to 'Quoted' status"
    echo "    2. Send proposals"
    echo "    3. Track responses"
    echo "  Goal: Qualify 3-5 opportunities"
    echo ""

    echo -e "${YELLOW}FRIDAY${NC}"
    echo "  Task: Review week and prepare next"
    echo "  Steps:"
    echo "    1. Check import_log.json for statistics"
    echo "    2. Review which sources performed best"
    echo "    3. Update configuration if needed"
    echo "    4. Plan cities to scrape next week"
    echo "  Result: 1-3 closed deals this week"
    echo ""

    read -p "Press Enter to continue to SECTION 11..."
}

################################################################################
# SECTION 11: QUICK COMMAND REFERENCE
################################################################################

show_section_11() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 11: QUICK COMMAND REFERENCE${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${YELLOW}MOST USED COMMANDS:${NC}"
    echo ""
    echo "Test with example data:"
    echo "  ${GREEN}cd /home/user/lead-pipeline && python quick_import.py${NC}"
    echo ""
    echo "Import real scraped data:"
    echo "  ${GREEN}cd /home/user/lead-pipeline && python scraper_api.py${NC}"
    echo ""
    echo "Start Flask API server:"
    echo "  ${GREEN}cd /home/user/lead-pipeline && python scraper_api.py${NC}"
    echo ""
    echo "Check API status:"
    echo "  ${GREEN}curl http://localhost:5000/api/leads/status${NC}"
    echo ""
    echo "View import log:"
    echo "  ${GREEN}cat /home/user/lead-pipeline/data/import_log.json${NC}"
    echo ""
    echo "View imported leads:"
    echo "  ${GREEN}cat /home/user/lead-pipeline/data/imported_leads.json${NC}"
    echo ""
    echo "Check Python version:"
    echo "  ${GREEN}python --version${NC}"
    echo ""
    echo "Install Flask:"
    echo "  ${GREEN}pip install flask${NC}"
    echo ""
    echo "Schedule daily import:"
    echo "  ${GREEN}crontab -e${NC}"
    echo "  Add: ${GREEN}0 9 * * * cd /home/user/lead-pipeline && python scraper_api.py${NC}"
    echo ""

    read -p "Press Enter to continue to SECTION 12..."
}

################################################################################
# SECTION 12: SUMMARY
################################################################################

show_section_12() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}SECTION 12: YOU'RE READY! NEXT STEPS${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${GREEN}✅ WHAT YOU NOW KNOW:${NC}"
    echo ""
    echo "  1. How to test with example data (5 min)"
    echo "  2. How to view leads in the dashboard"
    echo "  3. How to scrape real Google Maps businesses"
    echo "  4. How to import leads automatically"
    echo "  5. How the data transformation works"
    echo "  6. How to customize the configuration"
    echo "  7. How to automate daily scraping"
    echo "  8. How to monitor and optimize"
    echo "  9. How to troubleshoot problems"
    echo "  10. Complete day-by-day workflow"
    echo ""

    echo -e "${GREEN}🚀 IMMEDIATE NEXT STEPS (When you have your PC):${NC}"
    echo ""
    echo "  Step 1: Test the system (5 minutes)"
    echo "    ${GREEN}cd /home/user/lead-pipeline${NC}"
    echo "    ${GREEN}python quick_import.py${NC}"
    echo ""
    echo "  Step 2: Open dashboard"
    echo "    Open: /home/user/lead-pipeline/punchlist-lead-desk.html"
    echo ""
    echo "  Step 3: Set up Google Maps scraper"
    echo "    Follow google-maps-scraper README"
    echo ""
    echo "  Step 4: Run first real import"
    echo "    Get scraped data → Save as scraped_businesses.json"
    echo "    ${GREEN}python scraper_api.py${NC}"
    echo ""
    echo "  Step 5: Start contacting leads"
    echo "    Filter hot leads (70+) in dashboard"
    echo "    Make calls/send messages"
    echo ""

    echo -e "${GREEN}📚 DOCUMENTATION TO READ:${NC}"
    echo ""
    echo "  • SCRAPER_SETUP_GUIDE.md (800+ lines of detailed setup)"
    echo "  • COMPLETE_SYSTEM_MAP.md (full architecture overview)"
    echo "  • INTEGRATION_GUIDE.md (technical details)"
    echo ""

    echo -e "${GREEN}⏱️ EXPECTED TIMELINE:${NC}"
    echo ""
    echo "  Day 1 (Monday):"
    echo "    • Set up Google Maps scraper"
    echo "    • Run first scrape"
    echo "    • Import leads"
    echo "    • View in dashboard"
    echo ""
    echo "  Day 2-3 (Tuesday-Wednesday):"
    echo "    • Contact hot leads"
    echo "    • Track responses"
    echo ""
    echo "  Day 4-5 (Thursday-Friday):"
    echo "    • Follow up with interested"
    echo "    • Qualify opportunities"
    echo "    • Close first deals"
    echo ""
    echo "  Week 2+:"
    echo "    • Expand to more cities"
    echo "    • Automate daily scraping"
    echo "    • Scale to 50+ deals/month"
    echo ""

    echo -e "${GREEN}🎯 SUCCESS METRICS:${NC}"
    echo ""
    echo "  Week 1:"
    echo "    ✓ 300+ leads imported"
    echo "    ✓ 50+ hot leads identified"
    echo "    ✓ 20+ initial contacts made"
    echo ""
    echo "  Month 1:"
    echo "    ✓ 1000+ leads imported"
    echo "    ✓ 30-50 qualified opportunities"
    echo "    ✓ 5-10 deals closed"
    echo ""

    echo ""
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║  You have everything you need. Let's make this work!          ║"
    echo "║                                                              ║"
    echo "║  When you're ready with your PC, start with:                 ║"
    echo "║    cd /home/user/lead-pipeline && python quick_import.py     ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
}

################################################################################
# MAIN MENU
################################################################################

show_main_menu() {
    while true; do
        echo ""
        echo "╔════════════════════════════════════════════════════════════════╗"
        echo "║               HANDYMAN LEAD SCRAPER GUIDE MENU                 ║"
        echo "╚════════════════════════════════════════════════════════════════╝"
        echo ""
        echo "  1. Section 1: Before You Start"
        echo "  2. Section 2: Quick Test (5 minutes)"
        echo "  3. Section 3: View in Dashboard"
        echo "  4. Section 4: Real Google Maps Scrape"
        echo "  5. Section 5: How Transformation Works"
        echo "  6. Section 6: Customize Configuration"
        echo "  7. Section 7: Automate Daily Scraping"
        echo "  8. Section 8: Monitor and Optimize"
        echo "  9. Section 9: Troubleshooting"
        echo "  10. Section 10: Complete Workflow"
        echo "  11. Section 11: Command Reference"
        echo "  12. Section 12: Summary & Next Steps"
        echo "  0. Exit"
        echo ""
        read -p "Choose a section (0-12): " choice

        case $choice in
            1) show_section_1 ;;
            2) show_section_2 ;;
            3) show_section_3 ;;
            4) show_section_4 ;;
            5) show_section_5 ;;
            6) show_section_6 ;;
            7) show_section_7 ;;
            8) show_section_8 ;;
            9) show_section_9 ;;
            10) show_section_10 ;;
            11) show_section_11 ;;
            12) show_section_12; break ;;
            0) echo "Goodbye!"; exit 0 ;;
            *) echo "Invalid choice. Please try again." ;;
        esac
    done
}

# Run the main menu
show_main_menu
