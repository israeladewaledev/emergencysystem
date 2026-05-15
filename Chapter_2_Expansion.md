# CHAPTER TWO: LITERATURE REVIEW (EXPANSION)

## 2.3 Theoretical Framework for AI in Healthcare
The integration of Artificial Intelligence (AI) in healthcare is not merely a technical upgrade but a paradigm shift across several structural building blocks. According to Vishwakarma et al. (2023), AI applications can be categorized into six primary healthcare system building blocks originally defined by the WHO:

1.  **Health Services:** AI facilitates telemedicine and online consultations, which are critical for providing remote assistance during emergencies.
2.  **Health Workforce:** By automating repetitive and administrative tasks, AI reduces the burden on medical staff, allowing them to focus on critical care.
3.  **Health Information:** AI enhances electronic health records (EHR) and enables real-time health risk alerts, which are vital for emergency monitoring.
4.  **Medical Technologies:** Real-time data processing and health outcome prediction models allow for proactive rather than reactive medical interventions.
5.  **Health Finance:** AI can optimize resource allocation and financial planning within healthcare institutions.
6.  **Leadership and Governance:** AI-driven statistical models support decision-making processes for administrators, especially during crisis management.

## 2.4 Machine Learning Techniques in Emergency Response
Machine Learning (ML) has become a cornerstone for real-time decision-making in emergency situations. Richardson et al. (2021) identified several key ML techniques used in emergency response systems:

*   **Classification (Random Forest, SVM, Neural Networks):** Used extensively for triage and risk assessment. Random Forest, in particular, is frequently employed due to its high accuracy and ability to handle heterogeneous data inputs.
*   **Clustering (K-Means, DBSCAN):** Helpful for identifying "hotspots" or regions with a high concentration of emergency reports, enabling better resource deployment.
*   **Predictive Modeling:** Leveraging historical and real-time data to forecast the escalation of crisis scenarios, such as the spread of a pandemic or the progression of a mass casualty event.
*   **Reinforcement Learning (RL):** Ideal for dynamic decision-making, where the system "learns" from environmental feedback to optimize ambulance dispatch and routing in real-time.

## 2.5 Real-Time Data Integration and Challenges
A "smart" emergency system depends on the seamless integration of data from various sources. These include:
*   **IoT Sensors:** Wearables and environmental sensors that provide vitals or situational data.
*   **Mobile and Social Media Data:** Real-time updates from users that can alert responders to unfolding incidents before official reports come in.
*   **Geospatial Data:** Essential for location tracking and efficient dispatching.

However, the implementation of such systems faces significant barriers. Data quality is often cited as the most significant challenge (40% impact according to recent studies), followed by the "black box" nature of AI models, which leads to issues with interpretability and trust among medical professionals (Richardson et al., 2021). Ethical concerns regarding privacy and the handling of sensitive medical data remain a primary roadblock for widespread adoption.

## 2.6 Resilience and Sustainability in Campus Health Systems
The concept of a "resilient" healthcare system is one that can withstand shocks—such as a sudden surge in emergency cases at a university—and maintain high-quality care (Wiig et al., 2020). For a campus-specific system like that of Nile University, sustainability is achieved by minimizing resource waste through precise triage and ensuring the system is maintainable without the need for prohibitively expensive national-level infrastructure.

## 2.8 The Role of Mobile Health (mHealth) in Emergency Management
The ubiquity of smartphones has transformed them into vital tools for "mHealth" (mobile health), particularly in university settings where the student population is highly digitized. Sun et al. (2021) demonstrated that mobile platforms can effectively bridge the communication gap during crises, providing both psychological support and logistical coordination. In the context of emergency response, mHealth applications serve as a bidirectional interface: they allow victims to send instantaneous SOS alerts with embedded metadata (such as GPS coordinates and profile information) while enabling medical centers to push critical instructions or "first aid" guidance back to the scene. The effectiveness of these systems, however, is contingent on user engagement and the simplicity of the interface, as high levels of stress during an emergency can impair a user's ability to navigate complex menus.

## 2.9 IoT Integration for Real-Time Patient Monitoring
A key advancement in smart health systems is the integration of the Internet of Things (IoT). According to Shaik (2023), remote patient monitoring using AI-enabled IoT devices allows for the continuous tracking of physiological parameters such as heart rate, oxygen saturation, and body temperature. While the proposed system for Nile University primarily leverages user-reported data via mobile apps, the literature suggests that future scalability depends on incorporating wearable sensors. Tsao (2022) proposed a smart system using an MQTT broker, which facilitates low-latency data transmission between wearable devices and a central emergency hub. Such architectures ensure that even if a victim is unable to manually trigger an alert, the system can autonomously detect life-threatening anomalies and initiate a dispatch.

## 2.10 AI-Driven Triage and Manchester Triage System (MTS) Foundations
The core of any intelligent emergency system is its ability to prioritize cases—a process known as triage. Historically, triage has been a human-centric task, but recent studies by Tzenalis (2023) highlight the increasing role of AI in supporting clinical decisions. The Manchester Triage System (MTS) provides a five-level classification (Immediate, Very Urgent, Urgent, Standard, and Non-Urgent) that is highly suitable for rule-based AI logic. By digitizing the MTS flowcharts, a system can provide consistent, bias-free assessments that are not subject to the fatigue often experienced by triage nurses in high-pressure environments.

## 2.11 Security and Privacy in Smart Healthcare Infrastructure
As emergency systems move towards "Healthcare 5.0," the security of patient data becomes a paramount concern. Wazid et al. (2022) identify several security threats in decentralized health frameworks, ranging from data interception to unauthorized access of sensitive medical records. For a university-based system, maintaining a balance between rapid response (which requires immediate data access) and data privacy (which requires strict authentication) is critical. Implementing robust encryption protocols and secure cloud architectures, such as those provided by Firebase, is essential to mitigate these risks and ensure compliance with emerging data protection regulations in Nigeria.

## 2.12 Summary of Research Gaps
While large-scale national systems like Nigeria's "112" emergency line exist, they often lack the localized agility required for a university campus. Furthermore, many existing "smart" solutions rely heavily on expensive wearable hardware that is not feasible for an entire student body. There is a clear need for a mobile-based, AI-driven triage and dispatch system that leverages existing user devices to provide rapid, localized emergency response.
