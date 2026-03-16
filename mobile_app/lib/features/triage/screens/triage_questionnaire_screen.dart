import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import '../../sos/screens/emergency_status_screen.dart';
import '../../sos/services/sos_service.dart';
import '../../../core/theme/app_colors.dart';

class TriageQuestionnaireScreen extends ConsumerStatefulWidget {
  const TriageQuestionnaireScreen({super.key});

  @override
  ConsumerState<TriageQuestionnaireScreen> createState() => _TriageQuestionnaireScreenState();
}

class _TriageQuestionnaireScreenState extends ConsumerState<TriageQuestionnaireScreen> {
  int _currentStep = 0;
  final String _category = 'Medical Emergency';
  
  // Storing answers
  final Map<int, String> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Are you the one in need of medical assistance?',
      'options': ['Yes, I am', 'No, someone else'],
      'icon': Icons.person_search_rounded,
    },
    {
      'question': 'Is the patient conscious?',
      'options': ['Conscious', 'Unconscious', 'Semi-conscious'],
      'icon': Icons.accessibility_new_rounded,
    },
    {
      'question': 'What is the most visible symptom?',
      'options': ['Severe Bleeding', 'Chest Pain', 'Difficulty Breathing', 'Injury / Fracture', 'Other'],
      'icon': Icons.visibility_rounded,
    },
    {
      'question': 'Select emergency severity level:',
      'options': ['Critical (Life Threatening)', 'Major (High Urgency)', 'Minor (Low Urgency)'],
      'icon': Icons.priority_high_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final progress = (_currentStep + 1) / _questions.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Emergency Triage',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Custom Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${_currentStep + 1} of ${_questions.length}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textSecondary),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 8,
                      width: MediaQuery.of(context).size.width * 0.88 * progress,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFFFF7043)]),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: FadeInRight(
                key: ValueKey(_currentStep),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(_questions[_currentStep]['icon'] as IconData, color: AppColors.primary, size: 32),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _questions[_currentStep]['question'] as String,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary, height: 1.2),
                    ),
                    const SizedBox(height: 40),
                    ...(_questions[_currentStep]['options'] as List<String>).map((option) {
                      final isSelected = _answers[_currentStep] == option;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            setState(() => _answers[_currentStep] = option);
                            // Auto-advance after small delay if not last question
                            if (_currentStep < _questions.length - 1) {
                              Future.delayed(const Duration(milliseconds: 300), () {
                                if (mounted) setState(() => _currentStep++);
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : Colors.black.withOpacity(0.05),
                                width: 2,
                              ),
                              boxShadow: isSelected ? [
                                BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8)),
                              ] : [],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(Icons.check_circle_rounded, color: Colors.white)
                                else
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey.shade300, width: 2),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),

          // Navigation Bar
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5)),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  IconButton(
                    onPressed: () => setState(() => _currentStep--),
                    icon: const Icon(Icons.arrow_back_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.background,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _answers.containsKey(_currentStep) ? _handleSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      disabledBackgroundColor: Colors.grey.shade200,
                    ),
                    child: Text(
                      _currentStep == _questions.length - 1 ? 'DISPATCH EMERGENCY HELP' : 'CONTINUE',
                      style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_currentStep < _questions.length - 1) {
      setState(() => _currentStep++);
      return;
    }

    // Final Submission
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );

      final severity = _answers[3] ?? 'Major'; // Map based on question 4
      
      await ref.read(sosServiceProvider).triggerSOS(
        category: _category,
        severity: severity.split(' ').first, // Just get "Critical", "Major", etc.
      );

      if (mounted) {
        Navigator.pop(context); // Pop loading
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const EmergencyStatusScreen())
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Pop loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to alert help: $e'), backgroundColor: AppColors.primary),
        );
      }
    }
  }
}
