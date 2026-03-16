import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';

class FirstAidGuidanceScreen extends StatefulWidget {
  const FirstAidGuidanceScreen({super.key});

  @override
  State<FirstAidGuidanceScreen> createState() => _FirstAidGuidanceScreenState();
}

class _FirstAidGuidanceScreenState extends State<FirstAidGuidanceScreen> {
  String _searchQuery = "";
  String _selectedCategory = "All";

  final List<Map<String, dynamic>> _protocols = [
    {
      'icon': Icons.favorite_rounded,
      'title': 'Cardiac Arrest',
      'category': 'Cardiac',
      'desc': 'Check for breathing. Begin CPR immediately if unresponsive (30 compressions, 2 breaths).',
    },
    {
      'icon': Icons.water_drop_rounded,
      'title': 'Severe Bleeding',
      'category': 'Bleeding',
      'desc': 'Apply direct pressure to the wound using a clean cloth. Elevate the limb if possible.',
    },
    {
      'icon': Icons.local_fire_department_rounded,
      'title': 'Thermal Burns',
      'category': 'Burns',
      'desc': 'Cool the burn under cold running water for at least 20 minutes. Do not use ice.',
    },
    {
      'icon': Icons.do_not_disturb_on_rounded,
      'title': 'Choking',
      'category': 'Choking',
      'desc': 'Perform abdominal thrusts (Heimlich maneuver) just above the navel until object is clear.',
    },
    {
      'icon': Icons.person_off_rounded,
      'title': 'Fractures',
      'category': 'Other',
      'desc': 'Immobilize the injured area using a splint. Do not try to realign the bone.',
    },
    {
      'icon': Icons.bolt_rounded,
      'title': 'Seizures',
      'category': 'Other',
      'desc': 'Clear the area of sharp objects. Do not restrain the person. Time the seizure.',
    },
  ];

  List<Map<String, dynamic>> get _filteredProtocols {
    return _protocols.where((p) {
      final matchesSearch = p['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p['desc'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == "All" || p['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('First Aid Guidance'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search first aid tips...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryBlue),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Cardiac'),
                _buildFilterChip('Bleeding'),
                _buildFilterChip('Burns'),
                _buildFilterChip('Choking'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Protocol List
          Expanded(
            child: _filteredProtocols.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 64, color: Colors.grey[200]),
                        const SizedBox(height: 16),
                        Text('No protocols match your search', style: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _filteredProtocols.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) return _buildProtocolBanner();
                      final protocol = _filteredProtocols[index - 1];
                      return _buildProtocolCard(
                        protocol['icon'],
                        protocol['title'],
                        protocol['desc'],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (v) => setState(() => _selectedCategory = label),
        selectedColor: AppColors.primaryBlue,
        checkmarkColor: Colors.white,
        showCheckmark: false,
        backgroundColor: Colors.grey[100],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildProtocolBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.school_rounded, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                'NILE UNIVERSITY HEALTH',
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Campus First Aid Protocols',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Essential guidance for immediate response.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildProtocolCard(IconData icon, String title, String description) {
    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[100]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppColors.primaryBlue),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.4),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
