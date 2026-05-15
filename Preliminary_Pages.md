# PRELIMINARY PAGES

---

## DEDICATION

This work is dedicated to the Almighty God for His infinite wisdom, grace, and strength throughout this academic journey; to my beloved parents, whose unwavering support, sacrifices, and prayers have been the foundation of my success; to the students and staff of Nile University of Nigeria, whose safety and well-being inspired this research; and to all emergency responders who risk their lives daily to save others—may this work contribute to making their mission faster and more effective.

---

## ACKNOWLEDGEMENT

I express my profound gratitude to Almighty God for His divine guidance throughout this research and my entire academic program.

My deepest appreciation goes to my project supervisor, **[Supervisor Name]**, for invaluable mentorship and unwavering support. I am grateful to the Head of Department, Computer Engineering, and all faculty members for their knowledge and wisdom.

Special thanks to the **Nile University Clinic Staff**, particularly **[Clinic Director/Head Nurse Name]**, for granting access to understand the current emergency response workflow and providing valuable insights during requirement gathering.

I acknowledge my fellow students **[Friend 1]**, **[Friend 2]**, and **[Friend 3]** for their moral support and participation in system testing.

To my family—my parents **[Father's Name]** and **[Mother's Name]**, and my siblings—thank you for your endless love, prayers, and belief in my abilities.

Finally, I extend gratitude to all researchers whose works I referenced in this study.

May God bless you all abundantly.

---

## ABSTRACT

This project addresses critical challenges in emergency medical response at Nile University of Nigeria, where traditional manual reporting methods cause life-threatening delays during the "Golden Hour." The study proposes an **AI-Based Smart Health Emergency Response and Dispatch System** using Flutter mobile framework and Firebase cloud services to automate reporting, triage, and notification processes.

The system employs a **rule-based AI triage engine** based on the **Manchester Triage System (MTS)** to categorize emergencies into four priority levels (Red, Orange, Yellow, Green). Users trigger SOS alerts with one-touch functionality, while the system automatically captures GPS coordinates and broadcasts prioritized notifications to medical personnel within seconds.

Developed using the **Waterfall Model**, the system emphasizes sub-5-second latency, 99.9% uptime, end-to-end encryption, and stress-optimized UI design. Simulated emergency scenarios achieved an **average response time of 2.93 seconds** and **100% triage accuracy** against MTS standards. User Acceptance Testing confirmed high satisfaction with the application's simplicity and reliability.

This research demonstrates that high-impact AI solutions can be implemented at institutional scale using accessible cloud technologies, providing a blueprint for universities across Sub-Saharan Africa to enhance health system resilience.

**Keywords:** Artificial Intelligence, Emergency Response, Triage, Mobile Health, Manchester Triage System, Firebase, Flutter, Healthcare 5.0.

---

## DECLARATION

I, **[YOUR FULL NAME]**, hereby declare that this project report titled **"AI-Based Smart Health Emergency Response and Dispatch System: A Case Study of Nile University of Nigeria"** is the product of my original research work carried out under the supervision of **[Supervisor Name]**.

All sources of information used in this study have been duly acknowledged and referenced in accordance with academic standards. This work has not been previously submitted, either in whole or in part, for any degree or diploma at this or any other institution.

---

**Signature:** ___________________________  
**Name:** [YOUR FULL NAME]  
**Matriculation Number:** [YOUR MATRIC NO]  
**Date:** ___________________________

---

## CERTIFICATION

This is to certify that this project report titled **"AI-Based Smart Health Emergency Response and Dispatch System: A Case Study of Nile University of Nigeria"** was carried out by **[YOUR FULL NAME]** (Matriculation Number: **[YOUR MATRIC NO]**) in the Department of Computer Engineering, Faculty of Engineering, Nile University of Nigeria, in partial fulfillment of the requirements for the award of **Bachelor of Engineering (B.Eng.)** in Computer Engineering.

---

**Project Supervisor**  
**Name:** [Supervisor Name]  
**Signature:** ___________________________  
**Date:** ___________________________

---

**Head of Department**  
**Name:** [HOD Name]  
**Signature:** ___________________________  
**Date:** ___________________________

---

**External Examiner**  
**Name:** [Examiner Name]  
**Signature:** ___________________________  
**Date:** ___________________________

---

## TABLE OF CONTENTS

**PRELIMINARY PAGES**
- Title Page ................................................... i
- Declaration .................................................. ii
- Certification ................................................ iii
- Dedication ................................................... iv
- Acknowledgement .............................................. v
- Abstract ..................................................... vi
- Table of Contents ............................................ viii
- List of Figures .............................................. xi
- List of Tables ............................................... xii
- List of Abbreviations ........................................ xiii

**MAIN CHAPTERS**

**CHAPTER ONE: INTRODUCTION** .................................. 1
- 1.1 Background of the Study .................................. 1
- 1.2 Problem Statement ........................................ 4
- 1.3 Aim and Objectives ....................................... 6
  - 1.3.1 Aim .................................................. 6
  - 1.3.2 Objectives ........................................... 6
- 1.4 Significance of the Study ................................ 7
- 1.5 Scope and Limitation of the Study ........................ 9
  - 1.5.1 Scope ................................................ 9
  - 1.5.2 Limitations .......................................... 10
- 1.6 Case Study: Nile University of Nigeria ................... 11
- 1.7 Organization of the Study ................................ 12
- 1.8 Definition of Operational Terms .......................... 13
- 1.9 Motivation of the Study .................................. 14
- 1.10 Research Questions ...................................... 15

**CHAPTER TWO: LITERATURE REVIEW** ............................. 16
- 2.1 General Information ....................................... 16
- 2.2 Review of Existing Works ................................. 19
  - 2.2.1 Intelligent Traffic Management and Signalization ..... 19
  - 2.2.2 Mobile-Based Reporting and Crowdsourcing Platforms ... 20
  - 2.2.3 AI-Driven Triage and Clinical Decision Support ...... 21
  - 2.2.4 Comparative Analysis of Existing Systems ............ 22
- 2.3 Related Works of Literature .............................. 23
  - 2.3.1 Artificial Intelligence and Machine Learning in Pre-Hospital Care ... 23
  - 2.3.2 The Internet of Medical Things (IoMT) and Wearable Integration ... 25
  - 2.3.3 mHealth Accessibility, User Experience (UX), and Student Engagement ... 27
  - 2.3.4 Cloud Computing and the Firebase Ecosystem in Real-Time Systems ... 29
  - 2.3.5 Cybersecurity and Data Privacy in Healthcare 5.0 .... 31
  - 2.3.6 The Manchester Triage System (MTS): Clinical Foundations ... 33
  - 2.3.7 Collaborative Emergency Networks and "Active" Resilience ... 35
  - 2.3.8 Human Reliability and "The Machine-in-the-Loop" ..... 37
- 2.4 Research Gaps ............................................ 39
- 2.5 Summary ................................................... 41

**CHAPTER THREE: SYSTEM ANALYSIS AND DESIGN** .................. 43
- 3.1 Analysis of Proposed System .............................. 43
- 3.2 System Description and Case Study ........................ 45
  - 3.2.1 System Description .................................. 45
  - 3.2.2 Case Study: Nile University of Nigeria .............. 46
- 3.3 Methodology ............................................... 47
  - 3.3.1 Software Development Life Cycle (SDLC) .............. 47
- 3.4 Requirement Engineering .................................. 49
  - 3.4.1 User Groups ......................................... 49
  - 3.4.2 Functional Requirements ............................. 50
  - 3.4.3 Non-Functional Requirements ......................... 52
- 3.5 System Design ............................................. 54
  - 3.5.1 High-Level Architecture ............................. 54
  - 3.5.2 Low-Level Design (UML Diagrams) ..................... 56
- 3.6 Data Design ............................................... 62
  - 3.6.1 Database Schema (NoSQL) ............................. 62
- 3.7 Interface Design .......................................... 65
- 3.8 System Testing Plan ....................................... 67
  - 3.8.1 Test Strategy ....................................... 67
  - 3.8.2 Test Plan Table ..................................... 68

**CHAPTER FOUR: IMPLEMENTATION AND RESULTS** ................... 70
- 4.1 Introduction .............................................. 70
- 4.2 Implementation Environment ................................ 71
- 4.3 System Key Features ....................................... 72
  - 4.3.1 User Registration and Profile ....................... 72
  - 4.3.2 Emergency Alert Module .............................. 73
  - 4.3.3 AI Triage Implementation ............................ 74
  - 4.3.4 Dispatch Notification ............................... 75
- 4.4 Results and Analysis ...................................... 76
  - 4.4.1 Simulation Scenarios ................................ 76
  - 4.4.2 Performance Metrics ................................. 77
- 4.5 User Acceptance Testing (UAT) ............................. 78

**CHAPTER FIVE: CONCLUSION AND RECOMMENDATIONS** ............... 80
- 5.1 Summary of the Study ...................................... 80
- 5.2 Achievements .............................................. 81
- 5.3 Conclusion ................................................ 82
- 5.4 Recommendations ........................................... 83

**REFERENCES** .................................................. 85

**APPENDICES** .................................................. 95
- Appendix A: User Survey Questionnaire ........................ 95
- Appendix B: System Screenshots ............................... 97
- Appendix C: Code Snippets (AI Triage Logic) .................. 102
- Appendix D: Test Case Results ................................ 105

---

## LIST OF FIGURES

- Figure 1.1: The Golden Hour Concept in Emergency Medicine .... 3
- Figure 2.1: Evolution of Healthcare from 1.0 to 5.0 .......... 17
- Figure 2.2: Manchester Triage System Flowchart ............... 34
- Figure 3.1: System Architecture (3-Tier Model) ............... 55
- Figure 3.2: Use Case Diagram .................................. 57
- Figure 3.3: Activity Diagram (Emergency Reporting Flow) ...... 58
- Figure 3.4: Sequence Diagram (Dispatch Process) .............. 59
- Figure 3.5: Class Diagram ..................................... 60
- Figure 3.6: Entity Relationship Diagram (NoSQL) .............. 63
- Figure 3.7: Data Flow Diagram (Level 0) ...................... 64
- Figure 3.8: Mobile App Interface (SOS Screen) ................ 66
- Figure 4.1: Development Environment Setup .................... 71
- Figure 4.2: Triage Form Interface ............................ 74
- Figure 4.3: Responder Dashboard ............................... 75
- Figure 4.4: Response Time Distribution Chart ................. 77
- Figure 4.5: User Satisfaction Survey Results ................. 79

---

## LIST OF TABLES

- Table 3.1: Functional Requirements ........................... 51
- Table 3.2: Non-Functional Requirements ....................... 53
- Table 3.3: Database Schema - Users Collection ................ 62
- Table 3.4: Database Schema - Emergencies Collection .......... 63
- Table 3.5: Test Plan Table ................................... 68
- Table 4.1: Simulation Scenario Results ....................... 76
- Table 4.2: Performance Metrics Summary ....................... 77
- Table 4.3: UAT Feedback Summary ............................... 78

---

## LIST OF ABBREVIATIONS

| Abbreviation | Full Meaning |
|:-------------|:-------------|
| AI | Artificial Intelligence |
| API | Application Programming Interface |
| AED | Automated External Defibrillator |
| BaaS | Backend as a Service |
| BYOD | Bring Your Own Device |
| COVID-19 | Coronavirus Disease 2019 |
| ED | Emergency Department |
| EMS | Emergency Medical Services |
| ESI | Emergency Severity Index |
| FCM | Firebase Cloud Messaging |
| FRAM | Functional Resonance Analysis Method |
| GCP | Google Cloud Platform |
| GPS | Global Positioning System |
| HIS | Health Information System |
| HTTPS | Hypertext Transfer Protocol Secure |
| IoMT | Internet of Medical Things |
| IoT | Internet of Things |
| IPS | Indoor Positioning System |
| JSON | JavaScript Object Notation |
| mHealth | Mobile Health |
| MIS | Management Information System |
| ML | Machine Learning |
| MQTT | Message Queuing Telemetry Transport |
| MTS | Manchester Triage System |
| NoSQL | Not Only Structured Query Language |
| PWA | Progressive Web Application |
| QoS | Quality of Service |
| REST | Representational State Transfer |
| SDLC | Software Development Life Cycle |
| SMS | Short Message Service |
| SOS | Save Our Souls (Emergency Alert) |
| TLS | Transport Layer Security |
| UAT | User Acceptance Testing |
| UI | User Interface |
| UML | Unified Modeling Language |
| UX | User Experience |
| WHO | World Health Organization |
| XAI | Explainable Artificial Intelligence |
