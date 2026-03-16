// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import "../../sos/screens/sos_home_screen.dart";
import "../controllers/auth_controller.dart";

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Form Controllers
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedBloodGroup = 'O+';
  bool _isLoading = false;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Emergency Help',
      'subtitle': 'in Seconds',
      'description': 'Report emergencies with one touch\nand get immediate assistance.',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBNpoX_bojvsdAZWioWYoiU6T8fn7u5X1kg_d0rNzmyvopGLvbgCgZ9-B6BUCIBa8rmTB7i1yi7cOjeV0WxjYcHKK0FUmsx8IEiHtIeZyMPFXGoVgnVjJlrWS_HpHEWPX4q_qQLXPBh2YHNScyA9ymZqbF8REnqPjIyKMguw4gJxeXQysVnekceOArjtZ02Dhx4Nx6ue4ixAoWaSMBDthlCauPG6g4gpWoyhBEzWtaLaRIDhJj9011F28IssdhNgEIDcZwxo4kX4F4'
    },
    {
      'title': 'Live Video',
      'subtitle': 'Consultation',
      'description': 'Connect with medical professionals\nvia real-time video during distress.',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBNpoX_bojvsdAZWioWYoiU6T8fn7u5X1kg_d0rNzmyvopGLvbgCgZ9-B6BUCIBa8rmTB7i1yi7cOjeV0WxjYcHKK0FUmsx8IEiHtIeZyMPFXGoVgnVjJlrWS_HpHEWPX4q_qQLXPBh2YHNScyA9ymZqbF8REnqPjIyKMguw4gJxeXQysVnekceOArjtZ02Dhx4Nx6ue4ixAoWaSMBDthlCauPG6g4gpWoyhBEzWtaLaRIDhJj9011F28IssdhNgEIDcZwxo4kX4F4'
    },
    {
      'title': 'Instant Triage',
      'subtitle': 'Medical Check',
      'description': 'Our smart system categorizes your\nemergency to prioritize response.',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBNpoX_bojvsdAZWioWYoiU6T8fn7u5X1kg_d0rNzmyvopGLvbgCgZ9-B6BUCIBa8rmTB7i1yi7cOjeV0WxjYcHKK0FUmsx8IEiHtIeZyMPFXGoVgnVjJlrWS_HpHEWPX4q_qQLXPBh2YHNScyA9ymZqbF8REnqPjIyKMguw4gJxeXQysVnekceOArjtZ02Dhx4Nx6ue4ixAoWaSMBDthlCauPG6g4gpWoyhBEzWtaLaRIDhJj9011F28IssdhNgEIDcZwxo4kX4F4'
    },
  ];

  Future<void> _handleRegistration() async {
    if (_nameController.text.isEmpty || _idController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authControllerProvider).signUp(
        fullName: _nameController.text,
        studentId: _idController.text,
        bloodGroup: _selectedBloodGroup,
        allergies: 'None',
        password: _passwordController.text,
      );

      if (mounted) {
        Navigator.pop(context); // Close dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SOSHomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showRegistrationDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Student Registration', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                const SizedBox(height: 8),
                const Text('Create your Nile Emergency account', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 24),
                _buildTextField(_nameController, 'Full Name', Icons.person_outline),
                const SizedBox(height: 16),
                _buildTextField(_idController, 'Student ID', Icons.badge_outlined),
                const SizedBox(height: 16),
                _buildBloodGroupDropdown(),
                const SizedBox(height: 16),
                _buildTextField(_passwordController, 'Password', Icons.lock_outline, obscure: true),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegistration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.uniBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white) 
                      : const Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
        prefixIcon: Icon(icon, color: AppColors.uniBlue, size: 20),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.uniBlue, width: 2),
        ),
      ),
    );
  }

  Widget _buildBloodGroupDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedBloodGroup,
      decoration: InputDecoration(
        labelText: 'Blood Group',
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
        prefixIcon: const Icon(Icons.bloodtype_outlined, color: AppColors.uniBlue, size: 20),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'].map((bg) {
        return DropdownMenuItem(value: bg, child: Text(bg));
      }).toList(),
      onChanged: (v) => setState(() => _selectedBloodGroup = v!),
    );
  }

  Future<void> _handleLogin() async {
    if (_idController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter ID and password')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authControllerProvider).signIn(
        studentId: _idController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SOSHomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed: ${e.toString().contains('Invalid login') ? 'Invalid ID or Password' : e}'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showLoginDialog() {
    _idController.clear();
    _passwordController.clear();
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Student Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                const SizedBox(height: 8),
                const Text('Access your secure campus profile', style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 24),
                _buildTextField(_idController, 'Student ID', Icons.badge_outlined),
                const SizedBox(height: 16),
                _buildTextField(_passwordController, 'Password', Icons.lock_outline, obscure: true),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.uniBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white) 
                      : const Text('Log In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            // Header: Branding
            FadeInDown(
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.uniBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.school_rounded, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'NILE UNIVERSITY',
                        style: TextStyle(
                          color: AppColors.uniBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'SAFE CAMPUS, SAFE FUTURE',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            
            // Onboarding Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Illustration
                      FadeIn(
                        child: Container(
                          height: 280,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(data['image']!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Text
                      FadeInUp(
                        child: Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black, height: 1.1),
                                children: [
                                  TextSpan(text: '${data['title']}\n'),
                                  TextSpan(text: data['subtitle']!, style: const TextStyle(color: AppColors.emergencyRed)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 48),
                              child: Text(
                                data['description']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.5, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Indicator
            SmoothPageIndicator(
              controller: _pageController,
              count: _onboardingData.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: AppColors.uniBlue,
                dotColor: Color(0xFFE0E0E0),
                dotHeight: 6,
                dotWidth: 6,
                expansionFactor: 4,
              ),
            ),
            const SizedBox(height: 48),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  FadeInUp(
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage < _onboardingData.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOutCubic,
                            );
                          } else {
                            _showRegistrationDialog();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.uniBlue,
                          elevation: 10,
                          shadowColor: AppColors.uniBlue.withOpacity(0.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentPage < _onboardingData.length - 1 ? 'Continue' : 'Sign Up with Student ID',
                              style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        TextButton(
                          onPressed: _showLoginDialog,
                          child: const Text('Log In', style: TextStyle(color: AppColors.uniBlue, fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'By continuing, you agree to Nile University\'s Safety Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
