import 'package:flutter/material.dart';
import "../../history/screens/first_aid_guidance_screen.dart";
import "../../history/screens/emergency_history_screen.dart";
import "../../history/screens/emergency_contacts_screen.dart";
import "../../profile/screens/profile_screen.dart";
import "../../triage/screens/triage_questionnaire_screen.dart";
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/alert_controller.dart';
import 'emergency_status_screen.dart';
import '../widgets/sos_button.dart';

class SOSHomeScreen extends StatelessWidget {
  const SOSHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Match light background from design
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    final alertAsync = ref.watch(latestAlertProvider);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            alertAsync.when(
                              data: (alert) {
                                if (alert == null || alert['status'] == 'resolved' || alert['status'] == 'cancelled') {
                                  return const SizedBox.shrink();
                                }
                                return FadeInDown(
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const EmergencyStatusScreen()),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: AppColors.emergencyRed,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(color: AppColors.emergencyRed.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                                            child: const Icon(Icons.emergency_share_rounded, color: Colors.white, size: 20),
                                          ),
                                          const SizedBox(width: 12),
                                          const Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('ACTIVE EMERGENCY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),
                                                Text('Tap to track responder status', style: TextStyle(color: Colors.white70, fontSize: 11)),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              loading: () => const SizedBox.shrink(),
                              error: (_, __) => const SizedBox.shrink(),
                            ),
                            _buildHeader(context),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: SOSButton(
                              onTriggered: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TriageQuestionnaireScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        _buildFooter(context),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return FadeInDown(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.local_hospital_rounded,
                    color: AppColors.emergencyRed,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nile Emergency',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'SYSTEM ONLINE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: const NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDMiCPkqxto3OopR_bd9s9I2ZfJzwJjWxtoBEQXnp0FlNSEtfWdZpDUK1tYB6S8ITrkRXWsQQI9oB0sMKcO8vYql86curotAkZgBgZSPiIqPlbKx9pvYjjdCoNycnBAmRLJW00c14_jYj7kUgTdJzYvvwl3ny6bjoEdA4IWqL4o53bww1mFFBWZAk_irVHT7_ESnfabGiB5X4-kfU1ChfB4hMMKz43u1_9jBhq79dQWkhilEE_pGExMDq5JXYvM9AZvoBKRqrSTTrY'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuickAction(
            context,
            icon: Icons.history_rounded,
            label: 'My History',
            color: Colors.blue,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmergencyHistoryScreen()),
            ),
          ),
          _buildQuickAction(
            context,
            icon: Icons.medical_services_rounded,
            label: 'First Aid',
            color: Colors.greenAccent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FirstAidGuidanceScreen()),
            ),
          ),
          _buildQuickAction(
            context,
            icon: Icons.contact_phone_rounded,
            label: 'Contacts',
            color: Colors.orange,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmergencyContactsScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return FadeInUp(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: (MediaQuery.of(context).size.width - 80) / 3,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey[100]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
