# Eraser.io Diagram Prompts for Chapter 3

## 1. System Architecture Diagram (3-Tier Architecture)

**Prompt:**
```
Create a 3-tier architecture diagram for an AI-Based Smart Health Emergency Response System with the following components:

PRESENTATION TIER:
- Flutter Mobile App (Android/iOS) for Students/Staff
- Web Dashboard for Medical Responders
- Admin Web Portal

APPLICATION TIER:
- Firebase Cloud Functions containing:
  - AI Triage Engine (Manchester Triage System)
  - Notification Dispatcher
  - Authentication Service
  - Geolocation Service

DATA TIER:
- Cloud Firestore (NoSQL Database) with collections:
  - Users
  - Emergencies
  - Staff
- Firebase Cloud Storage for media

Show bidirectional arrows between tiers with labels:
- "HTTPS/REST API" between Presentation and Application
- "Real-time Sync" between Application and Data
- Include Firebase Cloud Messaging (FCM) as a separate service connecting to all mobile devices

Use modern cloud architecture styling with clear separation of tiers.
```

---

## 2. Use Case Diagram

**Prompt:**
```
Create a UML use case diagram for an Emergency Response System with three actors:

ACTORS:
1. Reporter (Student/Staff) - stick figure on left
2. Medical Responder - stick figure on right
3. System Administrator - stick figure on bottom

USE CASES for Reporter:
- Register Account
- Login
- Trigger SOS Alert
- Answer Triage Questions
- View Dispatch Status
- Update Profile

USE CASES for Medical Responder:
- Login
- Receive Emergency Alert
- View Triage Details
- Accept Mission
- Navigate to Location
- Close Case
- Update Availability Status

USE CASES for Administrator:
- Manage Users
- View Emergency Logs
- Generate Reports
- View Analytics Dashboard
- Configure System Settings

SYSTEM USE CASES (automated):
- Calculate Severity Score (extends from Answer Triage Questions)
- Geocode Location (extends from Trigger SOS)
- Broadcast Notification (extends from Calculate Severity)
- Log Emergency Data

Show <<include>> and <<extend>> relationships where appropriate.
```

---

## 3. Activity Diagram (Emergency Reporting Flow)

**Prompt:**
```
Create an activity diagram showing the complete emergency reporting workflow:

START: User presses SOS button

ACTIVITIES:
1. System captures GPS coordinates
2. Decision: "Is user able to answer questions?"
   - YES → Display triage questionnaire
   - NO → Set default priority to RED
3. If questionnaire shown:
   - User answers MTS questions (Is victim conscious? Severe bleeding? Breathing difficulty?)
4. AI Engine calculates severity score
5. System creates emergency record in database
6. Decision: "Severity level?"
   - RED → Immediate broadcast to all staff + sound alarm
   - ORANGE → Broadcast to on-duty staff
   - YELLOW/GREEN → Queue notification
7. Push notification sent to medical staff devices
8. Parallel activities:
   - Staff member accepts request
   - User receives "Help is coming" confirmation
9. Staff navigates to location
10. Staff arrives and provides care
11. Staff closes case in system

END: Emergency resolved

Use swimlanes for: User, Mobile App, AI Engine, Database, Medical Staff
Include decision diamonds and merge points.
```

---

## 4. Sequence Diagram (Dispatch Process)

**Prompt:**
```
Create a UML sequence diagram for the emergency dispatch process with these participants:

PARTICIPANTS (left to right):
1. Reporter (Mobile App)
2. API Gateway
3. AI Triage Function
4. Firestore Database
5. FCM Service
6. Responder Device

SEQUENCE:
1. Reporter → API Gateway: POST /emergency {symptoms, location}
2. API Gateway → AI Triage Function: processTriage(data)
3. AI Triage Function → AI Triage Function: runMTS_Algorithm()
4. AI Triage Function returns: {severity: "RED", score: 95}
5. AI Triage Function → Firestore: createDocument(/emergencies/{id})
6. Firestore returns: {success: true, id: "EM123"}
7. Firestore → FCM Service: onWrite trigger
8. FCM Service → Responder Device: sendMulticast({topic: "medical_staff", priority: "high"})
9. Responder Device displays: "CRITICAL ALERT: Cardiac Arrest at Block B"
10. Responder Device → API Gateway: PATCH /emergency/EM123 {status: "accepted"}
11. API Gateway → Firestore: updateDocument(status)
12. Firestore → Reporter: realtime update listener
13. Reporter displays: "Dr. Ahmed is on the way (2 min)"

Show activation boxes for processing time and async messages where appropriate.
```

---

## 5. Class Diagram

**Prompt:**
```
Create a UML class diagram for the emergency response system with these classes:

CLASS: User
Attributes:
- uid: String (PK)
- fullName: String
- email: String
- role: Enum(student, staff, medic, admin)
- phoneNumber: String
- fcmToken: String
- createdAt: Timestamp
Methods:
+ register()
+ login()
+ updateProfile()

CLASS: Emergency
Attributes:
- emergencyId: String (PK)
- reporterUid: String (FK → User)
- status: Enum(pending, dispatched, resolved)
- triageLevel: Enum(Red, Orange, Yellow, Green)
- symptoms: Array<String>
- location: Location
- timestamp: Timestamp
- responderId: String (FK → User)
Methods:
+ create()
+ updateStatus()
+ assignResponder()
+ close()

CLASS: Location
Attributes:
- latitude: Double
- longitude: Double
- description: String
- buildingName: String
Methods:
+ geocode()
+ calculateDistance(Location other)

CLASS: TriageEngine
Attributes:
- mtsRules: Array<Rule>
- severityThresholds: Map
Methods:
+ processSymptoms(symptoms: Array): TriageResult
+ calculateScore(answers: Map): Integer
+ determinePriority(score: Integer): Enum

CLASS: Notification
Attributes:
- notificationId: String
- emergencyId: String (FK → Emergency)
- recipientIds: Array<String>
- sentAt: Timestamp
- deliveryStatus: Map
Methods:
+ send()
+ trackDelivery()

RELATIONSHIPS:
- User "1" ←→ "0..*" Emergency (as reporter)
- User "1" ←→ "0..*" Emergency (as responder)
- Emergency "1" → "1" Location (composition)
- TriageEngine processes Emergency
- Emergency "1" → "0..*" Notification
```

---

## 6. Entity Relationship Diagram (NoSQL Structure)

**Prompt:**
```
Create a comprehensive NoSQL database schema diagram for Cloud Firestore showing:

COLLECTION: users
Document ID: {uid}
Fields:
{
  uid: string (PK)
  fullName: string
  studentId: string (unique, indexed)
  role: "student" | "staff" | "medic" | "admin"
  email: string (unique)
  phone: string
  department: string
  bloodGroup: string
  allergies: string[]
  emergencyContact: {
    name: string
    phone: string
    relationship: string
  }
  fcmToken: string
  isActive: boolean
  lastLogin: timestamp
  createdAt: timestamp
}
SUBCOLLECTION: users/{uid}/medicalHistory
- previousConditions: string[]
- medications: string[]
- lastUpdated: timestamp

---

COLLECTION: emergencies
Document ID: {emergencyId}
Fields:
{
  emergencyId: string (PK)
  reporterUid: string → references users/{uid}
  victimUid: string → references users/{uid} (nullable if victim is reporter)
  status: "pending" | "dispatched" | "enroute" | "arrived" | "resolved" | "cancelled"
  priority: "Red" | "Orange" | "Yellow" | "Green"
  
  triage: {
    level: "Red" | "Orange" | "Yellow" | "Green"
    symptoms: string[]
    isConscious: boolean
    isBreathing: boolean
    hasSevereBleeding: boolean
    painLevel: number (1-10)
    score: number
    processedBy: "AI" | "Manual"
    processedAt: timestamp
  }
  
  location: {
    lat: number
    lng: number
    accuracy: number
    description: string
    building: string
    floor: string
    room: string
    landmark: string
  }
  
  responderId: string → references users/{uid}
  responderAcceptedAt: timestamp
  responderArrivedAt: timestamp
  
  outcome: {
    treatmentProvided: string
    hospitalTransfer: boolean
    hospitalName: string
    notes: string
  }
  
  createdAt: timestamp (indexed)
  updatedAt: timestamp
  resolvedAt: timestamp
}
SUBCOLLECTION: emergencies/{id}/timeline
- action: string
- performedBy: string → references users/{uid}
- timestamp: timestamp
- details: object

---

COLLECTION: staff
Document ID: {staffId}
Fields:
{
  staffId: string (PK) → references users/{uid}
  specialization: "doctor" | "nurse" | "paramedic" | "first_aider"
  certifications: string[]
  yearsOfExperience: number
  availabilityStatus: "available" | "busy" | "off_duty"
  currentLocation: {
    lat: number
    lng: number
    lastUpdated: timestamp
  }
  assignedEmergencies: string[] → references emergencies/{id}
  performanceMetrics: {
    totalCasesHandled: number
    avgResponseTime: number
    rating: number
  }
}

---

COLLECTION: notifications
Document ID: {notificationId}
Fields:
{
  notificationId: string (PK)
  emergencyId: string → references emergencies/{id}
  recipientUid: string → references users/{uid}
  type: "emergency_alert" | "dispatch_update" | "case_closed"
  priority: "high" | "normal" | "low"
  title: string
  body: string
  data: object
  sentAt: timestamp
  deliveredAt: timestamp
  readAt: timestamp
  status: "sent" | "delivered" | "read" | "failed"
}

---

COLLECTION: locations
Document ID: {locationId}
Fields:
{
  locationId: string (PK)
  buildingName: string
  buildingCode: string
  floors: number
  coordinates: {
    lat: number
    lng: number
  }
  aedLocations: array[{floor: string, description: string}]
  emergencyExits: array[{floor: string, description: string}]
  accessibilityInfo: string
  campusZone: "academic" | "residential" | "sports" | "admin"
}

---

COLLECTION: analytics
Document ID: {date} (YYYY-MM-DD)
Fields:
{
  date: string (PK)
  totalEmergencies: number
  byPriority: {
    red: number
    orange: number
    yellow: number
    green: number
  }
  byStatus: {
    resolved: number
    pending: number
    cancelled: number
  }
  avgResponseTime: number (seconds)
  avgResolutionTime: number (seconds)
  topLocations: array[{building: string, count: number}]
  topSymptoms: array[{symptom: string, count: number}]
  peakHours: array[{hour: number, count: number}]
}

---

COLLECTION: systemLogs
Document ID: {logId}
Fields:
{
  logId: string (PK)
  timestamp: timestamp (indexed)
  level: "info" | "warning" | "error" | "critical"
  module: "auth" | "triage" | "dispatch" | "notification"
  action: string
  userId: string → references users/{uid}
  details: object
  ipAddress: string
}

---

COLLECTION: triageRules
Document ID: {ruleId}
Fields:
{
  ruleId: string (PK)
  ruleName: string
  mtsCategory: string
  conditions: array[{
    symptom: string
    operator: "equals" | "contains" | "greater_than"
    value: any
  }]
  priorityOutput: "Red" | "Orange" | "Yellow" | "Green"
  scoreWeight: number
  isActive: boolean
  lastUpdated: timestamp
  updatedBy: string → references users/{uid}
}

---

COLLECTION: feedback
Document ID: {feedbackId}
Fields:
{
  feedbackId: string (PK)
  emergencyId: string → references emergencies/{id}
  submittedBy: string → references users/{uid}
  rating: number (1-5)
  responseTime: "excellent" | "good" | "average" | "poor"
  staffProfessionalism: number (1-5)
  systemEaseOfUse: number (1-5)
  comments: string
  submittedAt: timestamp
}

---

RELATIONSHIPS (show with arrows):
1. users/{uid} ←→ emergencies/{id} (as reporter) [1:N]
2. users/{uid} ←→ emergencies/{id} (as victim) [1:N]
3. users/{uid} ←→ emergencies/{id} (as responder) [1:N]
4. staff/{id} → users/{uid} [1:1]
5. emergencies/{id} ←→ notifications/{id} [1:N]
6. emergencies/{id} → locations/{id} [N:1]
7. emergencies/{id} ←→ feedback/{id} [1:1]
8. triageRules/{id} used by emergencies (dashed line)
9. systemLogs/{id} references users/{uid} [N:1]

Use different colors for each collection:
- Users/Staff: Blue
- Emergencies: Red
- Notifications: Orange
- Analytics/Logs: Green
- Locations: Purple
- Triage Rules: Yellow
- Feedback: Pink
```

---

## 7. Data Flow Diagram (Level 0 - Context Diagram)

**Prompt:**
```
Create a Level 0 DFD (Context Diagram) showing:

CENTRAL SYSTEM: "AI Emergency Response System" (circle in center)

EXTERNAL ENTITIES:
1. Student/Staff Reporter (square, top-left)
2. Medical Responder (square, top-right)
3. Administrator (square, bottom)
4. GPS Service (square, left)
5. Firebase Cloud (square, right)

DATA FLOWS:
From Reporter to System:
- Emergency Alert
- Symptom Data
- Location Permission

From System to Reporter:
- Dispatch Confirmation
- ETA Updates

From System to Responder:
- Priority Alert
- Triage Details
- Navigation Data

From Responder to System:
- Acceptance Status
- Arrival Confirmation
- Case Closure

From Administrator to System:
- Configuration Updates
- User Management

From System to Administrator:
- Analytics Reports
- System Logs

From GPS Service to System:
- Coordinates

From System to Firebase:
- Store Emergency Data
- Retrieve User Profiles

Label all arrows with data flow names.
```

---

## 8. Deployment Diagram

**Prompt:**
```
Create a UML deployment diagram showing:

NODES:

1. User Device (Mobile)
   - <<device>> Android/iOS Smartphone
   - Contains: Flutter App (APK/IPA)
   - Connection: 4G/WiFi

2. Google Cloud Platform
   - <<cloud>> GCP us-central1
   - Contains:
     * Firebase Hosting (Web Dashboard)
     * Cloud Functions (Node.js Runtime)
     * Cloud Firestore (NoSQL Database)
     * Firebase Cloud Messaging
     * Cloud Storage
   - Connection: HTTPS/WSS

3. Admin Workstation
   - <<device>> Laptop/Desktop
   - Contains: Web Browser
   - Connection: HTTPS

4. Medical Staff Device
   - <<device>> Tablet/Smartphone
   - Contains: Web App (PWA)
   - Connection: Campus WiFi

CONNECTIONS:
- User Device ←→ GCP: REST API (HTTPS), WebSocket (Real-time)
- Admin Workstation ←→ GCP: HTTPS
- Medical Staff Device ←→ GCP: HTTPS, FCM Push
- GCP internal: Cloud Functions ←→ Firestore (gRPC)

Show protocols on connection lines and deployment artifacts in each node.
```

---

## Usage Instructions for Eraser.io:

1. Go to https://app.eraser.io
2. Create a new diagram
3. Select "Diagram-as-Code" mode
4. Copy and paste each prompt above
5. Eraser.io will auto-generate the diagram
6. Refine using the AI chat or manual editing
7. Export as PNG/SVG for your report

**Pro Tips:**
- Start with the System Architecture diagram first
- Use consistent color schemes across all diagrams
- Export at high resolution (300 DPI) for print quality
- Save the diagram code for future edits
