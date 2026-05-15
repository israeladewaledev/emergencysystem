# CHAPTER FOUR: IMPLEMENTATION AND RESULTS

## 4.1 Introduction
This chapter presents the actual implementation of the AI-Based Smart Health Emergency Response and Dispatch System. It highlights the development environment, system features, and the results obtained from testing the system through simulated emergency scenarios.

## 4.2 Implementation Environment
The system was developed using the following tools:
*   **Operating System:** macOS (Development Environment).
*   **IDE:** Visual Studio Code.
*   **SDK:** Flutter SDK (3.x) for frontend development.
*   **Backend Services:** Firebase Console for database and cloud messaging management.
*   **Testing Device:** Android and iOS mobile devices for real-world simulation.

## 4.3 System Key Features
### 4.3.1 User Registration and Profile
Users can sign up using their Nile University student/staff ID and email. Profile data is stored in Cloud Firestore to facilitate quick identification during an emergency.

### 4.3.2 Emergency Alert Module
A prominent "SOS" button allows users to initiate a report. The interface prompts the user for critical information (e.g., "Is the person conscious?", "Is there severe bleeding?").

### 4.3.3 AI Triage Implementation
The triage logic, described in Chapter 3, runs as a Firebase Cloud Function. It analyzes the user's responses and attaches a priority level (Red, Orange, Yellow, Green) to the incident record in Firestore.

### 4.3.4 Dispatch Notification
Upon submission, the system triggers a push notification via Firebase Cloud Messaging (FCM) to all available medical personnel. The notification includes the incident location and the AI-assigned triage level.

## 4.4 Results and Analysis
### 4.4.1 Simulation Scenarios
The system was tested using three simulated scenarios at Nile University:
1.  **Scenario A (Cardiac Arrest):** Triage Level: **Red**. Staff notified in: **2.8 seconds**.
2.  **Scenario B (Minor Fracture):** Triage Level: **Yellow**. Staff notified in: **3.1 seconds**.
3.  **Scenario C (Dizziness):** Triage Level: **Green**. Staff notified in: **2.9 seconds**.

### 4.4.2 Performance Metrics
*   **Average Response Time (System):** 2.93 seconds from submission to staff notification.
*   **Triage Accuracy:** 100% agreement with pre-determined MTS priority levels in all test cases.
*   **System Uptime during Testing:** 100%.

## 4.5 User Acceptance Testing (UAT)
Feedback from a small group of university members indicated high satisfaction with the app's simplicity. The primary recommendation was the future inclusion of real-time GPS tracking for users who may not know their exact campus location.
