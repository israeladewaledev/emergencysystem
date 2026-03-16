import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _picker = ImagePicker();
  bool _emergencyAlerts = true;
  bool _locationSharing = true;

  Future<void> _pickAndUploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        await ref.read(profileControllerProvider.notifier).uploadAvatar(File(image.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e'))
        );
      }
    }
  }

  void _showEditProfileDialog(Map<String, dynamic> profile) {
    final nameController = TextEditingController(text: profile['full_name']);
    final bloodController = TextEditingController(text: profile['blood_group']);
    final allergiesController = TextEditingController(text: profile['allergies']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Edit Medical Information', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Full Name')),
            TextField(controller: bloodController, decoration: const InputDecoration(labelText: 'Blood Group')),
            TextField(controller: allergiesController, decoration: const InputDecoration(labelText: 'Allergies')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              await ref.read(profileControllerProvider.notifier).updateProfile(
                fullName: nameController.text,
                bloodGroup: bloodController.text,
                allergies: allergiesController.text,
              );
              if (mounted) Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (profile) {
          if (profile == null) return const Center(child: Text('User not found'));

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header Card
                FadeInDown(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: _pickAndUploadImage,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: AppColors.primary.withOpacity(0.1),
                                  backgroundImage: profile['avatar_url'] != null 
                                      ? NetworkImage(profile['avatar_url']) 
                                      : null,
                                  child: profile['avatar_url'] == null 
                                      ? const Icon(Icons.person, size: 50, color: AppColors.primary) 
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 3),
                                    ),
                                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          profile['full_name'] ?? 'Loading...',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Student ID: ${profile['student_id'] ?? 'N/A'}',
                          style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Medical Information Section
                _buildSectionLabel('Medical Information'),
                const SizedBox(height: 12),
                _buildInfoTile(
                  icon: Icons.bloodtype,
                  color: Colors.red.shade400,
                  label: 'Blood Group',
                  value: profile['blood_group'] ?? 'Not set',
                  onTap: () => _showEditProfileDialog(profile),
                ),
                _buildInfoTile(
                  icon: Icons.warning_rounded,
                  color: Colors.orange.shade400,
                  label: 'Allergies',
                  value: profile['allergies'] ?? 'None',
                  onTap: () => _showEditProfileDialog(profile),
                ),
                _buildInfoTile(
                  icon: Icons.shield_rounded,
                  color: Colors.blue.shade400,
                  label: 'Medical Insurance',
                  value: 'Primary Student Health Plan',
                  onTap: () {},
                ),

                const SizedBox(height: 32),
                
                // Account Settings
                _buildSectionLabel('Account Settings'),
                const SizedBox(height: 12),
                _buildToggleTile(
                  icon: Icons.notifications_active_rounded,
                  color: Colors.purple.shade400,
                  label: 'Emergency Alerts',
                  value: _emergencyAlerts,
                  onChanged: (v) => setState(() => _emergencyAlerts = v),
                ),
                _buildToggleTile(
                  icon: Icons.location_on_rounded,
                  color: Colors.teal.shade400,
                  label: 'Location Sharing',
                  value: _locationSharing,
                  onChanged: (v) => setState(() => _locationSharing = v),
                ),

                const SizedBox(height: 32),
                
                // Security
                _buildSectionLabel('Security'),
                const SizedBox(height: 12),
                _buildInfoTile(
                  icon: Icons.lock_rounded,
                  color: Colors.grey.shade600,
                  label: 'Change Password',
                  value: 'Last updated 3 months ago',
                  onTap: () {},
                ),

                const SizedBox(height: 48),
                
                // Footer
                Center(
                  child: Column(
                    children: [
                      const Opacity(
                        opacity: 0.3,
                        child: Text(
                          'NILE UNIVERSITY EMERGENCY SYSTEM',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Privacy Policy • Terms of Service', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.03)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                    Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade300, size: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required Color color,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.03)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            ),
            Switch.adaptive(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
