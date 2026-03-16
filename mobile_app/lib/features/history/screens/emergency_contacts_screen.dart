import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';

class EmergencyContactsScreen extends ConsumerStatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  ConsumerState<EmergencyContactsScreen> createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends ConsumerState<EmergencyContactsScreen> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _contacts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return;

      final data = await _supabase
          .from('emergency_contacts')
          .select()
          .eq('user_id', user.id);
      
      if (mounted) {
        setState(() {
          _contacts = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _contacts.isEmpty
              ? _buildEmptyState()
              : _buildContactsList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddContactDialog(),
        label: const Text('Add Contact', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.person_add_rounded),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.contact_emergency_rounded, size: 80, color: Colors.grey[200]),
          const SizedBox(height: 20),
          const Text('No contacts added yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 10),
          const Text('Add someone to notify in emergencies', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey[100]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: const Icon(Icons.person, color: AppColors.primaryBlue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contact['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(contact['relation'] ?? 'Relation', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  final phone = contact['phone'];
                  if (phone != null && phone.isNotEmpty) {
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: phone,
                    );
                    if (await canLaunchUrl(launchUri)) {
                      await launchUrl(launchUri);
                    }
                  }
                },
                icon: const Icon(Icons.call, color: AppColors.success),
              ),
              IconButton(
                onPressed: () async {
                  await _supabase.from('emergency_contacts').delete().eq('id', contact['id']);
                  _fetchContacts();
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddContactDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final relationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone')),
            TextField(controller: relationController, decoration: const InputDecoration(labelText: 'Relation')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final user = _supabase.auth.currentUser;
              if (user == null) return;
              await _supabase.from('emergency_contacts').insert({
                'user_id': user.id,
                'name': nameController.text,
                'phone': phoneController.text,
                'relation': relationController.text,
              });
              if (context.mounted) Navigator.pop(context);
              _fetchContacts();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
