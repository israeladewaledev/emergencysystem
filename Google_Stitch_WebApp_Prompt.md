# Google Stitch Comprehensive Prompt: Web App for AI-Based Smart Health Emergency Response System

**Context:**
I am building the "AI-Based Smart Health Emergency Response and Dispatch System" for Nile University of Nigeria. The mobile app (used by students to send SOS alerts) is already designed. Now, I need you (Google Stitch / AI UI Generator) to design the **Web Application** portion of this system. 

The Web App serves two main user roles:
1. **Medical Responders (Doctors/Nurses/Paramedics):** They use it as a command center to receive SOS alerts, view AI triage results, access patient medical records, track victims on a live campus map, and coordinate dispatch.
2. **System Administrators:** They use it to monitor overall system health, manage user accounts (staff, students, medics), configure the AI triage rules, and view deep analytics on emergency response times and campus health trends.

This prompt is intentionally detailed and comprehensive to ensure every gradient, layout choice, interactive element, and data visualization is meticulously rendered. Please interpret this entire document as your design brief.

---

## 1. GLOBAL DESIGN SYSTEM AND AESTHETICS

Before diving into specific pages, establish the global design language that must persist across all screens. The design must be hyper-modern, exuding a "Healthcare 5.0" aesthetic that balances high-tech data density with medical clarity and urgency-driven focus.

**1.1 Color Palette & Semantics:**
*   **Primary System Color (Trust & Medical):** Deep Cerulean Blue (`#0F4C81`). Used for primary navigation, active states, and brand headers.
*   **Secondary System Color (Accent):** Teal (`#00B4D8`). Used for secondary buttons, subtle highlights, and progress indicators.
*   **Backgrounds:** 
    *   App Background: Off-white/very light gray (`#F8F9FA`) to reduce eye strain during long shifts.
    *   Surface/Cards: Pure White (`#FFFFFF`) with subtle, large-blur drop shadows for depth and a "glassmorphism" touch where appropriate.
    *   Dark Mode Alternative (Optional/Toggle): Deep Navy/Charcoal (`#121212`) backgrounds with elevated surfaces in (`#1E1E1E`).
*   **Semantic Urgency Colors (CRITICAL to the system's function):**
    *   **RED (Life-Threatening):** `#D32F2F` or a vibrant Crimson. Pulsating effects should be used for active red alerts. Used for Cardiac arrests, severe bleeding, unconsciousness.
    *   **ORANGE (Urgent):** `#F57C00`. Used for fractures, severe asthma, high pain levels.
    *   **YELLOW (Standard):** `#FBC02D`. Used for moderate injuries, sickness.
    *   **GREEN (Non-Urgent/Success):** `#388E3C`. Used for resolved cases, successful dispatch, and non-critical ailments.
*   **Typography:**
    *   Font Family: **Inter** or **Roboto**. Clean, highly legible sans-serif.
    *   Hierarchy: 
        *   H1/Headers: Bold, 24px-32px, Deep Charcoal (`#212121`).
        *   Body Text: Regular, 14px-16px, Slate Gray (`#424242`).
        *   Metatext/Timestamps: Medium, 12px, Light Gray (`#757575`).
        *   Numbers/KPIs in Dashboards: Monospaced font for quick scanning (e.g., Roboto Mono).

**1.2 Layout & Grid System:**
*   Sidebar Navigation Architecture: A collapsible left sidebar (240px expanded, 72px collapsed) for main menu navigation.
*   Top App Bar: 64px height. Contains universal search, status toggle (Available/Busy), notification bell, and user profile avatar.
*   Content Area: Masonry grid layout with 24px gutters/padding. Cards should have 12px-16px border-radius to feel modern and approachable.

**1.3 Interactivity & Micro-interactions:**
*   **Hover States:** Cards should lift slightly (increase shadow spread) on hover. Buttons should lighten by 10%.
*   **Urgency Animations:** Active RED alerts must have a subtle "breathing" or "pulsating" glow effect to draw the dispatcher's eye immediately.
*   **Transitions:** Smooth slide-ins for modals and side-panels.
*   **Accessibility:** High contrast ratios (WCAG AAA for text), clear focus states for keyboard navigation, and tooltip descriptions for all icons.

---

## 2. MEDICAL RESPONDER PAGES (The Command Center)

The following pages are specific to the Medical Responder role. This UI must be optimized for speed, clarity, and decision-making under severe pressure.

### 2.1 The Live Dispatch Dashboard (Default Landing Page)
**Purpose:** The central hub where medics monitor incoming SOS alerts in real-time. It must be split-screen: a list of alerts on the left, and a live map on the right.

**Detailed Breakdown:**

*   **Left Column (40% width) - The Triage Queue:**
    *   **Queue Header:** Title "Live Incident Queue". Next to it, a toggle switch: "Auto-Sort by Criticality" (enabled by default).
    *   **Priority Filters:** A horizontal row of pill-shaped chips: `[All: 14]`, `[🔴 Critical: 2]`, `[🟠 Urgent: 5]`, `[🟡 Standard: 7]`.
    *   **Emergency Cards (The core element):** Design a vertically scrolling list of cards representing active SOS alerts.
        *   *Card variations based on MTS Triage:*
        *   **Critical Card (Example):** Needs a thick red left border. 
            *   Top left: Blinking red dot with "RED PRIORITY - CARDIAC". 
            *   Top right: Timestamp "00:45 ago".
            *   Middle: Patient Name "John Doe (Student)".
            *   Location: "Block B, Floor 2, Room 204".
            *   Distance tag: "150 meters away".
            *   Bottom: Primary primary action button: "Accept & Dispatch" (Green solid). Secondary button: "View Details" (Outlined).
        *   **Standard Card (Example):** Thick yellow left border. 
            *   Contains similar data but lacks the pulsating urgency.
*   **Right Column (60% width) - The Interactive Campus Map:**
    *   A high-definition, stylised map of "Nile University Campus".
    *   **Map Features:**
        *   Custom map styling (e.g., Snazzy Maps default light blue/gray scheme).
        *   **Pins:** Different styled markers for different elements.
            *   Victim Pins: Color-coded pulsing dots corresponding to their triage level (Red, Orange, Yellow).
            *   Medic/Responder Pins: Blue circular icons with a white cross, showing the real-time location of colleagues traversing the campus.
            *   Infrastructure Pins: Yellow lightning bolt icons denoting the location of AEDs (Automated External Defibrillators) or emergency medical kits across campus buildings.
    *   **Map Overlay/HUD:** 
        *   Top right of the map: Layer controls (Satellite, 3D Building view, Traffic/Congestion).
        *   Bottom left of the map: "Quick Focus" buttons to snap the camera to the currently selected emergency.

---

### 2.2 Triage Details & Medical Action View (Modal / Slide-out Panel)
**Purpose:** When a medic clicks "View Details" on an emergency card, a large side-panel slides in from the right, covering 60% of the screen.

**Detailed Breakdown:**

*   **Panel Header:** 
    *   Large colorful banner indicating priority (e.g., Red gradient).
    *   "Incident #EM-2026-089A"
    *   Status: "Pending Dispatch".
    *   Close 'X' button.
*   **Section 1: AI Triage Summary:**
    *   A prominent card showing the AI's deductions based on the Manchester Triage System (MTS).
    *   "Calculated Severity: LEVEL 1 (RED) - Immediate Life Threat".
    *   "AI Confidence Score: 98%".
    *   **Symptom Checklist (Submitted by user):**
        *   [x] Unconscious: YES
        *   [x] Breathing: NO/ABNORMAL
        *   [x] Chest Pain: YES
    *   **AI Recommendation Banner:** A highlighted yellow box stating: "Probable Cardiac Arrest. Dispatch with AED immediately. Contact Campus Security for crowd control."
*   **Section 2: Patient Context & Medical History (The 'Golden Record'):**
    *   Profile photo (circular), Name, Age, Sex, University ID.
    *   **Critical Alerts sub-section:** 
        *   "Blood Group: O-" (Red badge).
        *   "Allergies: Penicillin, Peanuts" (Red badge).
        *   "Chronic Conditions: Severe Asthma" (Warning badge).
    *   Emergency Contact Info: Mother's Name, Phone Number, "Call Now" button.
*   **Section 3: Response Action Center (The bottom sticky footer of the panel):**
    *   This is where the medic takes control.
    *   **Assign Responder Dropdown:** Shows a list of available on-duty staff, sorted by proximity to the victim. "Assign to: Nurse Fatima (50m away)".
    *   **Action Buttons:**
        *   Primary (Huge, Green): "Dispatch Now" (triggers notifications).
        *   Secondary (Blue): "Initiate Tele-Consultation" (opens video call window).
        *   Tertiary (Red Outline): "Escalate to National Ambulance (112)".

---

### 2.3 Tele-Consultation & Dispatch Comm Center
**Purpose:** A dedicated screen for remote communication while a responder is en route, or if the situation requires visual assessment before dispatch.

**Detailed Breakdown:**

*   **Layout:** Split screen. Left side is video/audio, right side is medical charting.
*   **Left Side (Video Interface):**
    *   Large video feed of the patient/reporter scene.
    *   Picture-in-Picture (PiP) of the doctor's webcam in the bottom right.
    *   Floating control bar: Mute, Stop Video, Share Screen, End Call (Red pill).
    *   Overlaid on the video feed in the top left: Live vital signs if connected to an IoMT (Internet of Medical Things) wearable (e.g., "Heart Rate: 130 BPM, SpO2: 88%").
*   **Right Side (Live Charting & Dispatch Notes):**
    *   **Live Chat/Log:** An area recording timestamps. (10:02am: Call initiated. 10:03am: Patient confirms shortness of breath).
    *   **Quick Actions Panel:** Buttons for rapid charting: "Mark patient stable", "Instruct CPR", "Notify Security".
    *   **Draft Medical Report input field:** Rich text editor for the doctor to type clinical notes while observing.
    *   "Save & Append to Patient Record" button.

---

## 3. SYSTEM ADMINISTRATOR PAGES (The Analytics Hub)

The following pages are strictly for the `Admin` role. They focus on macro-level data, system configuration, and performance tracking rather than individual emergencies. The design language here should shift slightly from "urgency" to "business intelligence" and "command oversight."

### 3.1 Administrator Master Dashboard
**Purpose:** The high-level executive view of how the campus emergency system is performing over time. It should look like a modern SaaS analytics dashboard.

**Detailed Breakdown:**

*   **Header & Filters:**
    *   "University Health System Overview".
    *   Date Range Picker: "Last 30 Days" | "This Semester" | "Year to Date".
    *   Export Button: "Download PDF/CSV Report".
*   **Top Row (Key Performance Indicators - KPIs):**
    *   Four sleek, glassmorphic cards displaying crucial metrics. Each must have an icon, a large number, and a trend indicator (e.g., a green arrow pointing down for improved times).
        1.  **Total Incidents:** "412" (+5% from last month).
        2.  **Average Response Time:** "2 min 45 sec" (-12% improvement). Highlight this card algorithmically if it drops below the 3-minute goal.
        3.  **Critical (Red) Cases:** "18" (represents 4.3% of total).
        4.  **System Uptime:** "99.98%" (Green check icon).
*   **Middle Row (Data Visualization & Charts):**
    *   **Chart 1: Incidents Over Time (Line Graph).**
        *   X-Axis: Days of the month.
        *   Y-Axis: Number of reports.
        *   Lines: Four distinct lines matching the triage colors (Red, Orange, Yellow, Green). Smooth, cubic bezier curves. Tooltips on hover showing exact numbers.
    *   **Chart 2: Incident Heatmap / Campus Zones (Bar Chart or Radar Chart).**
        *   Showing which buildings have the most emergencies (e.g., "Faculty of Engineering: 45", "Male Hostel A: 120", "Sports Complex: 85").
*   **Bottom Row (Operational Tables):**
    *   **Staff Performance Matrix:**
        *   A data table listing medical staff.
        *   Columns: Staff Name, Role, Cases Handled, Average Dispatch Time, Patient Rating (Stars), Status (Online/Offline).
        *   Include a search bar and pagination.

---

### 3.2 AI Triage & System Configuration
**Purpose:** The settings page where administrators can adjust the underlying logic of the Manchester Triage System within the AI engine.

**Detailed Breakdown:**

*   **Layout:** Two-column layout. Left column is a list of specific symptoms/triggers. Right column is the rule editor.
*   **Left Column (Trigger Library):**
    *   List of medical inputs the mobile app accepts (e.g., "Severe Bleeding", "Loss of Consciousness", "Fever > 40C", "Chest Pain").
    *   Search bar to filter triggers.
*   **Right Column (Rule Editor Interface):**
    *   Visual representation of the decision tree.
    *   **Rule Builder:**
        *   "IF [Symptom] = 'Unconscious' AND [Age] > '50'"
        *   "THEN SET Priority = [Dropdown: RED]"
        *   "AND NOTIFY = [All Staff]"
    *   Include toggle switches to turn specific AI rules on or off.
    *   "Test Rule Engine" button: Opens a mock mobile simulator within the web app to trigger a fake SOS and see how the AI categorizes it, allowing the admin to verify configurations safely.

---

### 3.3 User & Patient Management
**Purpose:** The CRM (Customer Relationship Management) section for the university population.

**Detailed Breakdown:**

*   **Directory View:**
    *   A massive, organized table of all registered users in the system.
    *   Tabs: "All Users" | "Students" | "Academic Staff" | "Medical Responders".
    *   Columns: Unique ID (e.g., Matric No), Name, Department, Blood Group, Last Login, Verification Status.
*   **User Detail View (When a row is clicked):**
    *   Card-based profile view.
    *   Ability for admins to manually update "High-Risk Patient" tags (e.g., tagging a student known to have severe epilepsy so they always default to an Orange priority upon reporting).
    *   "Deactivate Account" button (for graduated students).
    *   "Reset Password" button.

---

## 4. TECHNICAL UI CONSIDERATIONS TO INCLUDE IN YOUR GENERATION

Please ensure the generated designs explicitly showcase:

1.  **Empty States:** What does the Dispatch Dashboard look like when there are zero active emergencies? (It should be calming, perhaps an illustration of a peaceful campus with text "All clear. Campus is secure.")
2.  **Notification Toasts:** Temporary floating snackbars at the top right of the screen (e.g., green toast: "Dr. Fatima accepted Incident #402"; red toast warning: "Connection to Firebase lost! Reconnecting...").
3.  **Loading Skeletons:** Show wireframe placeholders where data is being fetched from the cloud to indicate app performance processing.
4.  **Responsive Behaviors:** In your descriptions or layout logic, imply how the UI collapses. For example, mention that on an iPad/Tablet view (often used in ambulances), the Sidebar automatically collapses into icons only, and the Map dominates the screen.

**Summary Goal:**
Generate the most highly-detailed, pixel-perfect, scalable web application design system for an Emergency Dispatch center. It needs to look like a multi-million-dollar enterprise software (think Palantir or modern Epic Systems healthcare software) tailored specifically for the context of Nile University. Every pixel must serve the purpose of reducing cognitive load for doctors resolving critical emergencies in seconds.
