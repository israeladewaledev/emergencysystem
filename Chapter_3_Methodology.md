# CHAPTER THREE: SYSTEM ANALYSIS AND DESIGN

## 3.1 Introduction
This chapter details the methodology adopted for the development of the AI-Based Smart Health Emergency Response and Dispatch System. It describes the system architecture, requirements engineering, and the logic behind the AI-driven triage process.

## 3.2 Research Methodology
The software development life cycle (SDLC) followed for this project is the **Waterfall Model**. This model ensures a structured approach where each phase (Requirements, Analysis, Design, Implementation, Testing) is completed before moving to the next, which is ideal for ensuring the medical accuracy and reliability required for a health-response system.

## 3.3 System Analysis
### 3.3.1 User Groups
1.  **Casualty/Reporter:** Any member of the university community who uses the mobile app to report an emergency.
2.  **Medical Staff:** Personnel at the university clinic who receive triage results and dispatch notifications.
3.  **Administrator:** Manages user records, system logs, and evaluates response efficiency statistics.

### 3.3.2 Functional Requirements
*   **User Registration & Authentication:** Secure sign-in for university members.
*   **Emergency Reporting:** A user-friendly interface to submit emergency alerts.
*   **AI-Driven Triage:** An automated assessment of the case based on user-provided symptoms.
*   **Swift Notification:** Instant push notifications sent to medical personnel.
*   **Admin Dashboard:** Oversight of current and past emergency records.

### 3.3.3 Non-Functional Requirements
*   **Performance:** The system must process triage and send notifications within 5 seconds.
*   **Reliability:** The backend must ensure 99.9% uptime to handle emergencies at any time.
*   **Usability:** Simple, high-contrast UI for use under high-stress conditions.
*   **Security:** End-to-end encryption for sensitive health data.

## 3.4 System Design
### 3.4.1 High-Level Architecture
The system follows a **Client-Server Architecture** leveraging cloud services for scalability:
*   **Frontend:** Developed using **Flutter** (for cross-platform mobile compatibility).
*   **Backend:** Powered by **Firebase**.
    *   *Cloud Firestore:* NoSQL database for real-time data sync.
    *   *Firebase Authentication:* Secure user management.
    *   *Firebase Cloud Messaging (FCM):* For dispatch notifications.
*   **AI Engine:** A rule-based decision tree implemented as a **Cloud Function**.

### 3.4.2 AI Triage Logic
The "AI" component utilizes a rule-based expert system based on the **Manchester Triage System (MTS)**. It analyzes inputs such as:
- Airway/Breathing status
- Level of consciousness
- Presence of severe bleeding
- Mechanism of injury

The algorithm assigns one of the following priority levels:
- **Level 1 (Red):** Immediate Resuscitation.
- **Level 2 (Orange):** Very Urgent.
- **Level 3 (Yellow):** Urgent.
- **Level 4 (Green):** Standard/Non-urgent.

## 3.5 Database Design
The database schema involves several key collections:
*   **Users:** `uid`, `name`, `id_number`, `role`, `phone`.
*   **Emergencies:** `incident_id`, `reporter_uid`, `triage_level`, `timestamp`, `status` (Pending/Dispatched/Resolved).
*   **Staff:** `staff_uid`, `specialization`, `availability_status`.

## 3.6 Evaluation Plan
The system will be evaluated using simulated emergency scenarios at Nile University to measure:
1.  Average time from report submission to staff notification.
2.  Accuracy of the AI-assigned triage level against a medical professional's baseline.
