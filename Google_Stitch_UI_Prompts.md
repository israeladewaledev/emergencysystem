# Google Stitch UI Design Prompts
## AI-Based Smart Health Emergency Response System

---

## 1. Mobile App - SOS Home Screen (Reporter View)

**Prompt:**
```
Design a mobile app home screen for an emergency health response system with these specifications:

LAYOUT:
- Clean, minimalist design with a white/light gray background
- Large red circular SOS button in the center (60% of screen height)
- Button has a pulsating glow effect to draw attention
- Inside the button: white "SOS" text in bold sans-serif font (72pt)
- Below button text: "Press & Hold for 3 Seconds"

TOP SECTION:
- Status bar showing time, battery, signal
- App header with "Nile Emergency" logo (left)
- Profile icon (top right corner)
- Green "Online" status indicator

BOTTOM SECTION:
- Three small icon buttons in a row:
  * "My History" (clock icon)
  * "First Aid Tips" (medical cross icon)
  * "Emergency Contacts" (phone icon)

DESIGN STYLE:
- Modern, flat design with subtle shadows
- High contrast for stress situations
- Accessibility-friendly (WCAG AAA compliant)
- Safe area padding for notched phones
- Color scheme: Red (#E53935), White (#FFFFFF), Gray (#F5F5F5)

ANNOTATIONS:
- Add "Long press prevents accidental triggers" note
- Show finger press gesture indicator
```

---

## 2. Triage Questionnaire Screen

**Prompt:**
```
Design a mobile triage questionnaire screen with a conversational card-based interface:

LAYOUT:
- Progress bar at top showing "Question 2 of 5"
- Large card in center with rounded corners (16px radius)
- Question text at top of card in large, readable font (24pt)
- Two large action buttons below question

CARD CONTENT:
- Icon representing the question (e.g., lungs icon for breathing)
- Question: "Is the victim breathing normally?"
- Subtext: "Look for chest movement and listen for breath sounds"

BUTTONS:
- "YES" button (left) - Green (#4CAF50), with checkmark icon
- "NO" button (right) - Red (#E53935), with X icon
- Buttons are 48px height minimum (touch-friendly)
- Haptic feedback indicator

BOTTOM SECTION:
- "Skip" button (gray, small)
- "Emergency detected - Help is being dispatched" banner (if critical answer)

DESIGN STYLE:
- Card-based UI with drop shadows
- Smooth transitions between questions
- Visual feedback on button press
- Color-coded severity indicators
- Sans-serif font (Roboto or Inter)

ACCESSIBILITY:
- High contrast text
- Large touch targets
- Voice-over compatible labels
```

---

## 3. Dispatch Confirmation Screen

**Prompt:**
```
Design a confirmation screen shown after emergency is reported:

LAYOUT:
- Full-screen success state
- Animated checkmark icon at top (green, pulsating)
- Main message in center
- ETA countdown timer
- Responder details card
- Action buttons at bottom

MAIN CONTENT:
- Large green checkmark icon (animated)
- Heading: "Help is on the way!"
- Subheading: "Dr. Ahmed has accepted your request"
- ETA: "Estimated arrival: 2 minutes" (with countdown)

RESPONDER CARD:
- Profile photo (circular, 64px)
- Name: "Dr. Ahmed Ibrahim"
- Role: "Emergency Physician"
- Status: "En route" (with moving dot animation)
- Distance: "150m away"

MAP SECTION:
- Small embedded map showing:
  * Your location (red pin)
  * Responder location (blue pin with medical cross)
  * Route line between them

BOTTOM BUTTONS:
- "Call Responder" (primary button, blue)
- "Cancel Request" (secondary button, gray)
- "View Instructions" (text link)

DESIGN STYLE:
- Calming color palette (greens and blues)
- Smooth animations
- Real-time updates
- Material Design 3 principles
```

---

## 4. Medical Responder Dashboard (Web/Tablet)

**Prompt:**
```
Design a web dashboard for medical staff to view and manage emergency alerts:

LAYOUT (Desktop/Tablet):
- Left sidebar navigation (240px width)
- Main content area with emergency cards
- Right panel with map view

LEFT SIDEBAR:
- Nile Emergency logo at top
- Navigation items:
  * "Active Emergencies" (with red badge showing count)
  * "My Cases"
  * "History"
  * "Analytics"
- User profile at bottom with "Available" toggle switch

MAIN CONTENT AREA:
- Filter tabs: "All | Red | Orange | Yellow | Green"
- Emergency cards in vertical list, sorted by priority
- Each card shows:
  * Priority badge (color-coded circle)
  * Time reported (e.g., "2 min ago")
  * Location: "Block B, Room 305"
  * Primary symptom: "Severe chest pain"
  * Reporter name and photo
  * Distance: "200m"
  * "Accept" button (green) and "Details" button (gray)

CARD DESIGN:
- Red border for critical cases
- Pulsating animation for new alerts
- Expandable for full triage details

RIGHT PANEL (MAP):
- Interactive campus map
- Pins for all active emergencies (color-coded)
- Your current location (blue dot)
- AED locations (yellow pins)

DESIGN STYLE:
- Professional medical interface
- Dark mode option
- Data-dense but organized
- Quick-action oriented
- Color scheme: Blue (#1976D2), Red (#E53935), White (#FFFFFF)
```

---

## 5. Triage Details Modal (Responder View)

**Prompt:**
```
Design a modal/popup showing detailed triage information for medical staff:

MODAL LAYOUT:
- Overlay with semi-transparent dark background
- White card in center (max-width 600px)
- Close button (X) in top-right corner

HEADER SECTION:
- Large priority badge (Red/Orange/Yellow/Green)
- "CRITICAL EMERGENCY" or appropriate severity label
- Time reported: "3 minutes ago"

PATIENT INFORMATION:
- Section heading: "Patient Details"
- Name: "John Doe (Student)"
- Age: "21 years"
- Blood Group: "O+"
- Known Allergies: "Penicillin"
- Emergency Contact: "+234 xxx xxx xxxx"

TRIAGE ASSESSMENT:
- Section heading: "AI Triage Assessment"
- Severity Score: "95/100" with progress bar
- Primary Symptoms (with icons):
  * ✗ Not breathing normally
  * ✗ Unconscious
  * ✓ Severe bleeding
  * ✗ Chest pain
- Recommended Action: "Immediate resuscitation required. Bring AED."

LOCATION SECTION:
- Building: "Faculty of Engineering, Block B"
- Floor: "2nd Floor"
- Room: "Room 205"
- Landmark: "Near the Computer Lab"
- "Navigate" button with map icon

REPORTER INFORMATION:
- "Reported by: Sarah Ahmed (Student)"
- "Contact: +234 xxx xxx xxxx"
- "Call Reporter" button

BOTTOM ACTIONS:
- "Accept & Dispatch" (large green button)
- "Reassign" (secondary button)
- "Mark as False Alarm" (text link, red)

DESIGN STYLE:
- Clean, medical-grade interface
- Scannable information hierarchy
- Icon-based visual cues
- Print-friendly layout option
```

---

## 6. Admin Analytics Dashboard

**Prompt:**
```
Design an analytics dashboard for system administrators:

LAYOUT:
- Top navigation bar with date range selector
- 4 KPI cards in a row
- 2 large charts below
- Bottom section with tables

KPI CARDS (Top Row):
1. Total Emergencies: "127" (with +12% trend arrow)
2. Avg Response Time: "2.8 sec" (with -15% improvement)
3. Active Cases: "3" (pulsating red indicator)
4. System Uptime: "99.9%" (green checkmark)

CHARTS:
1. Line Chart (Left):
   - Title: "Emergency Trends (Last 30 Days)"
   - X-axis: Dates
   - Y-axis: Number of emergencies
   - Multiple lines for each priority level (color-coded)

2. Donut Chart (Right):
   - Title: "Emergencies by Priority"
   - Segments: Red (15%), Orange (25%), Yellow (40%), Green (20%)
   - Center shows total count

TABLES SECTION:
1. "Top Locations" table:
   - Columns: Location | Count | Avg Response Time
   - Top 5 buildings with most emergencies

2. "Responder Performance" table:
   - Columns: Name | Cases Handled | Avg Time | Rating
   - Sortable columns

FILTERS:
- Date range picker (top right)
- Export to PDF/Excel buttons
- Real-time update toggle

DESIGN STYLE:
- Data visualization best practices
- Color-blind friendly palette
- Responsive grid layout
- Dark mode support
- Professional business intelligence aesthetic
```

---

## 7. User Profile & Settings Screen

**Prompt:**
```
Design a user profile and settings screen for the mobile app:

LAYOUT:
- Header with back button
- Profile section at top
- Settings sections below
- Logout button at bottom

PROFILE SECTION:
- Large circular profile photo (120px)
- "Change Photo" button overlay
- Name: "John Doe"
- Student ID: "NU/2020/12345"
- Department: "Computer Engineering"
- Edit profile button (pencil icon)

MEDICAL INFORMATION CARD:
- Section heading: "Medical Information"
- Blood Group: "O+" (with edit icon)
- Allergies: "Penicillin, Peanuts" (with edit icon)
- Chronic Conditions: "Asthma" (with edit icon)
- "This information helps responders provide better care" (info text)

EMERGENCY CONTACT CARD:
- Section heading: "Emergency Contact"
- Name: "Jane Doe (Mother)"
- Phone: "+234 xxx xxx xxxx"
- Edit button

SETTINGS SECTIONS:
1. Notifications:
   - "Emergency Alerts" (toggle ON)
   - "System Updates" (toggle ON)
   - "Sound & Vibration" (toggle ON)

2. Privacy:
   - "Share Location" (toggle ON)
   - "Share Medical History with Responders" (toggle ON)

3. Accessibility:
   - "High Contrast Mode" (toggle OFF)
   - "Large Text" (toggle OFF)
   - "Voice Commands" (toggle OFF)

BOTTOM SECTION:
- "Logout" button (red, outlined)
- App version: "v1.0.2"
- "Privacy Policy" and "Terms of Service" links

DESIGN STYLE:
- Clean, organized sections
- Card-based layout
- Toggle switches for settings
- Consistent spacing (16px padding)
- Material Design components
```

---

## 8. First Aid Tips Screen

**Prompt:**
```
Design an educational screen showing first aid guidance:

LAYOUT:
- Search bar at top
- Category chips below search
- Scrollable card list
- Quick access floating button

SEARCH BAR:
- "Search first aid tips..." placeholder
- Magnifying glass icon
- Voice search icon (right)

CATEGORY CHIPS (Horizontal scroll):
- "All"
- "Cardiac"
- "Bleeding"
- "Burns"
- "Choking"
- "Fractures"
- Color-coded by severity

FIRST AID CARDS:
Each card contains:
- Icon representing the emergency (e.g., heart for cardiac)
- Title: "Cardiac Arrest"
- Brief description: "When someone's heart stops beating"
- "View Steps" button
- Bookmark icon (top-right)

EXPANDED CARD (When clicked):
- Step-by-step instructions with numbers
- Illustrations/diagrams for each step
- Warning box: "Call emergency services immediately"
- Video tutorial link (if available)
- "Done" button

FLOATING ACTION BUTTON:
- Red circular button (bottom-right)
- "Quick SOS" text
- Shortcut to emergency reporting

DESIGN STYLE:
- Educational, friendly tone
- Clear, simple illustrations
- Easy-to-scan format
- Offline-capable indicator
- Color scheme: Blue (#2196F3) for info, Red (#E53935) for warnings
```

---

## 9. Emergency History Screen

**Prompt:**
```
Design a screen showing user's past emergency reports:

LAYOUT:
- Header with "My Emergency History"
- Filter/sort options
- Timeline view of past emergencies
- Empty state (if no history)

FILTER OPTIONS:
- Dropdown: "Last 30 Days | Last 6 Months | All Time"
- Status filter chips: "All | Resolved | Cancelled"

TIMELINE CARDS:
Each card shows:
- Date and time: "Jan 15, 2026 - 2:30 PM"
- Status badge: "Resolved" (green) or "Cancelled" (gray)
- Priority indicator (colored dot)
- Location: "Block B, Room 305"
- Incident type: "Minor fracture"
- Responder: "Dr. Ahmed Ibrahim"
- Response time: "2.8 seconds"
- Resolution time: "15 minutes"
- "View Details" expandable arrow

EXPANDED DETAILS:
- Full timeline of events:
  * "Emergency reported - 2:30 PM"
  * "Dr. Ahmed accepted - 2:30 PM"
  * "Dr. Ahmed arrived - 2:33 PM"
  * "Case resolved - 2:45 PM"
- Treatment notes (if available)
- Feedback section: "Rate your experience" (stars)

EMPTY STATE:
- Illustration of a shield/checkmark
- Text: "No emergencies reported"
- Subtext: "We hope it stays that way!"

DESIGN STYLE:
- Timeline visualization
- Chronological order (newest first)
- Subtle dividers between cards
- Collapsible sections
- Calm, reassuring color palette
```

---

## 10. Login/Onboarding Screen

**Prompt:**
```
Design a welcoming login and onboarding screen:

ONBOARDING SLIDES (3 slides):

Slide 1:
- Illustration: Person pressing SOS button on phone
- Heading: "Emergency Help in Seconds"
- Text: "Report emergencies with one touch and get immediate assistance"

Slide 2:
- Illustration: AI brain analyzing symptoms
- Heading: "Smart AI Triage"
- Text: "Our AI assesses severity and alerts the right medical team"

Slide 3:
- Illustration: Medical staff rushing to help
- Heading: "Fast Response, Better Outcomes"
- Text: "Average response time under 3 seconds"

LOGIN SCREEN:
- Nile University logo at top
- App name: "Nile Emergency Response"
- Tagline: "Your Safety, Our Priority"

INPUT FIELDS:
- Student/Staff ID input (with university icon)
- Password input (with eye icon to show/hide)
- "Forgot Password?" link

BUTTONS:
- "Login" (primary button, full width, blue)
- "Sign Up" (secondary button, outlined)
- "Continue as Guest" (text link, for viewing tips only)

FOOTER:
- "By logging in, you agree to our Terms & Privacy Policy"
- Emergency hotline: "Call 112 for life-threatening emergencies"

DESIGN STYLE:
- Welcoming, trustworthy aesthetic
- University branding colors
- Smooth transitions between slides
- Dot indicators for slide position
- Gradient background (subtle)
```

---

## Usage Instructions for Google Stitch:

1. Go to https://stitch.google.com (or appropriate Google design tool)
2. Create a new project
3. Select "Mobile App" or "Web App" template
4. Copy and paste each prompt into the AI design generator
5. Customize colors to match Nile University branding
6. Export as PNG/Figma for your report
7. Annotate designs with feature callouts

**Design System Recommendations:**
- **Primary Color:** #E53935 (Red - for emergencies)
- **Secondary Color:** #1976D2 (Blue - for trust/medical)
- **Success Color:** #4CAF50 (Green)
- **Warning Color:** #FF9800 (Orange)
- **Font:** Roboto or Inter (highly readable)
- **Spacing:** 8px grid system
- **Corner Radius:** 8-16px for cards and buttons

**Accessibility Checklist:**
✅ Minimum 4.5:1 contrast ratio for text
✅ Touch targets at least 48x48px
✅ Support for screen readers
✅ Color is not the only indicator
✅ Large, readable fonts (minimum 16px body text)
