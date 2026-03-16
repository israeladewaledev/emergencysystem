import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../sos/controllers/alert_controller.dart';

class EmergencyHistoryScreen extends ConsumerStatefulWidget {
  const EmergencyHistoryScreen({super.key});

  @override
  ConsumerState<EmergencyHistoryScreen> createState() => _EmergencyHistoryScreenState();
}

class _EmergencyHistoryScreenState extends ConsumerState<EmergencyHistoryScreen> {
  final Set<String> _expandedIds = {};

  void _toggleExpanded(String id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(historyAlertsProvider);

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
          'My Emergency History',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: historyAsync.when(
        data: (alerts) {
          if (alerts.isEmpty) {
            return _buildEmptyState();
          }

          // Grouping logic (simplified for demo: This Month vs Older)
          final now = DateTime.now();
          final thisMonthAlerts = alerts.where((a) {
            final date = DateTime.parse(a['created_at']);
            return date.year == now.year && date.month == now.month;
          }).toList();
          final olderAlerts = alerts.where((a) {
            final date = DateTime.parse(a['created_at']);
            return !(date.year == now.year && date.month == now.month);
          }).toList();

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              _buildFilterBar(),
              if (thisMonthAlerts.isNotEmpty) ...[
                _buildSectionLabel('This Month'),
                ...thisMonthAlerts.map((a) => _buildHistoryCard(a)),
              ],
              if (olderAlerts.isNotEmpty) ...[
                const SizedBox(height: 24),
                _buildSectionLabel('Older'),
                ...olderAlerts.map((a) => _buildHistoryCard(a)),
              ],
              _buildEndIndicator(),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shield_outlined, size: 64, color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          const Text('No emergencies reported', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Stay safe, Nile University. Your history is empty.', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('This Month', active: true),
            _buildFilterChip('All Statuses'),
            _buildFilterChip('Clear', isAction: true),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool active = false, bool isAction = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.primary : (isAction ? AppColors.primary : Colors.white),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: active || isAction ? AppColors.primary : Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: active || isAction ? Colors.white : AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!isAction)
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(Icons.keyboard_arrow_down, size: 16, color: active ? Colors.white : Colors.grey),
            ),
          if (isAction)
            const Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(Icons.close, size: 14, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 12),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> alert) {
    final id = alert['id'];
    final isExpanded = _expandedIds.contains(id);
    final date = DateTime.parse(alert['created_at']);
    final status = (alert['status'] ?? 'pending').toString().toLowerCase();
    
    Color statusColor = AppColors.success;
    if (status == 'pending') statusColor = AppColors.urgentOrange;
    if (status == 'cancelled') statusColor = Colors.grey;

    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border(left: BorderSide(color: statusColor, width: 4)),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () => _toggleExpanded(id),
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('MMM dd, yyyy • HH:mm').format(date),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on_rounded, size: 14, color: AppColors.textSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  alert['location'] ?? 'Nile Campus',
                                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: AppColors.background),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.blue.shade50,
                          child: const Icon(Icons.medical_services, size: 14, color: Colors.blue),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                status == 'pending' ? 'Waiting for response' : 'Assigned to Unit 4',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              if (status != 'pending')
                                const Text('Paramedic Sarah James', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                            ],
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.background.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'CRITICAL PRIORITY',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTimeline(alert),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(Map<String, dynamic> alert) {
    final status = alert['status']?.toString().toLowerCase() ?? 'pending';
    final createdAt = DateTime.parse(alert['created_at']);
    
    return Column(
      children: [
        _buildTimelineStep('SOS Reported', DateFormat('HH:mm').format(createdAt), isFirst: true, isDone: true),
        _buildTimelineStep('Dispatch Accepted', '14:32', isDone: status != 'pending' && status != 'cancelled'),
        _buildTimelineStep('Unit Arrived', '14:38', isDone: status == 'resolved'),
        _buildTimelineStep('Resolved', '15:10', isLast: true, isDone: status == 'resolved', content: 'Patient transferred to campus clinic.'),
      ],
    );
  }

  Widget _buildTimelineStep(String label, String time, {bool isFirst = false, bool isLast = false, bool isDone = false, String? content}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: isDone ? Colors.blue : Colors.white,
                  border: Border.all(color: isDone ? Colors.blue : Colors.grey.shade300, width: 3),
                  shape: BoxShape.circle,
                ),
                child: isDone ? const Icon(Icons.check, size: 8, color: Colors.white) : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade200,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(label, style: TextStyle(fontWeight: isDone ? FontWeight.bold : FontWeight.bold, fontSize: 14, color: isDone ? AppColors.textPrimary : Colors.grey.shade400)),
                    Text(time, style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.grey.shade400)),
                  ],
                ),
                if (content != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 20),
                    child: Text(content, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                  ),
                if (content == null && !isLast) const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: Colors.grey.shade200)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('END OF HISTORY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 2)),
          ),
          Expanded(child: Container(height: 1, color: Colors.grey.shade200)),
        ],
      ),
    );
  }
}
