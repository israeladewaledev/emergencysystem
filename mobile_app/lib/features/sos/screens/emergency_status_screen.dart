// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/alert_controller.dart';
import '../controllers/chat_controller.dart';
import '../../history/screens/first_aid_guidance_screen.dart';

class EmergencyStatusScreen extends ConsumerWidget {
  const EmergencyStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertAsync = ref.watch(latestAlertProvider);

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
          'Dispatch Confirmed',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: alertAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (alert) {
          if (alert == null) {
            return const Center(child: Text('No active alerts.'));
          }

          final status = (alert['status'] ?? 'pending').toString().toLowerCase();
          final isAccepted = status == 'accepted' || status == 'dispatched';
          
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    // Hero Section
                    FadeInDown(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isAccepted ? Colors.green.shade50 : AppColors.primary.withOpacity(0.05),
                              shape: BoxShape.circle,
                              boxShadow: [
                                if (isAccepted) BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 20, spreadRadius: 5),
                              ],
                            ),
                            child: Icon(
                              isAccepted ? Icons.check_circle_rounded : Icons.pending_rounded,
                              color: isAccepted ? Colors.green : AppColors.primary,
                              size: 64,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            isAccepted ? 'Help is on the way!' : 'Distress Signal Sent',
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary, letterSpacing: -1),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isAccepted ? 'Dr. Ahmed has accepted your request.' : 'Waiting for responder assignment...',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ETA Section
                    _buildDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          const Text(
                            'ESTIMATED ARRIVAL',
                            style: TextStyle(color: AppColors.info, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                isAccepted ? '02' : '--',
                                style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, letterSpacing: -2),
                              ),
                              const SizedBox(width: 4),
                              const Text('min', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildDivider(),

                    const SizedBox(height: 24),

                    // Responder Card
                    _buildResponderCard(isAccepted, context, ref, alert['id']),

                    const SizedBox(height: 24),

                    // Live Map Widget (Simulated)
                    _buildMapWidget(),

                    const SizedBox(height: 140), // Spacer for sticky bottom
                  ],
                ),
              ),

              // Sticky Bottom Actions
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.background.withOpacity(0),
                        AppColors.background,
                        AppColors.background,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _callNumber(context, '0800-NILE-EMS', alertId: alert['id']), // Pass alertId for internet call
                        icon: const Icon(Icons.call, size: 20),
                        label: const Text('CALL RESPONDER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.info,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 64),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 8,
                          shadowColor: AppColors.info.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const FirstAidGuidanceScreen()),
                                );
                              },
                              icon: const Icon(Icons.menu_book, size: 20),
                              label: const Text('INSTRUCTIONS'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.textPrimary,
                                side: BorderSide(color: Colors.black.withOpacity(0.1)),
                                minimumSize: const Size(0, 56),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _handleCancel(alert['id'], context),
                              icon: const Icon(Icons.cancel, size: 20),
                              label: const Text('CANCEL'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(color: AppColors.primary, width: 2),
                                minimumSize: const Size(0, 56),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.grey.shade300, Colors.transparent],
        ),
      ),
    );
  }

  Widget _buildResponderCard(bool isAccepted, BuildContext context, WidgetRef ref, String alertId) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
        ],
        border: Border(left: BorderSide(color: isAccepted ? Colors.green : Colors.grey.shade300, width: 4)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?u=ahmed'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAccepted ? 'Dr. Ahmed' : 'Searching...',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  isAccepted ? 'Emergency Physician' : 'Assigning Responder',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (isAccepted)
            Row(
              children: [
                IconButton(
                  onPressed: () => _showChatSheet(context, ref, alertId),
                  icon: const Icon(Icons.chat_bubble_rounded, color: AppColors.info),
                  style: IconButton.styleFrom(backgroundColor: AppColors.info.withOpacity(0.1)),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMapWidget() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuC7vloVX_-pdtA4iRljDaYdCKhpc562meFlWm_UBtj4v8xY4Mizsy2MVfgq0wxLYwZZ1FYXVHdXT9sULUbzqDfNTh3SAd5xMRQPvc3Flt3Q8XV1d8ovjgZRQeF2GibkcvraZkvvg8R1UE6WzjQ4-0W3wy_V-WP8rq1dixpXrVGGQdvybDcZyH7bIZ6x3yd1c9EncTBJRvvXsdlTtlD5LkZb1tQOg3VWHevvgRk9TQ09X0pxGD3OdP0u2JnwjIT9DJ94OYpZvUrivVI',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on, size: 14, color: AppColors.info),
                  SizedBox(width: 4),
                  Text('LIVE TRACKING', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _callNumber(BuildContext context, String number, {String? alertId}) async {
    _showCallPicker(context, number, alertId);
  }

  void _showCallPicker(BuildContext context, String phoneNumber, String? alertId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            const Text('Choose Call Type', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Select how you want to connect with help', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _buildCallOption(
                    context,
                    icon: Icons.videocam_rounded,
                    label: 'Internet Call',
                    sublabel: 'Video/Audio',
                    color: AppColors.info,
                    onTap: () {
                      Navigator.pop(context);
                      final roomUrl = 'https://meet.jit.si/NileEmergency_${alertId ?? 'general'}';
                      launchUrl(Uri.parse(roomUrl), mode: LaunchMode.externalApplication);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildCallOption(
                    context,
                    icon: Icons.phone_rounded,
                    label: 'Phone Call',
                    sublabel: 'Standard Carrier',
                    color: AppColors.success,
                    onTap: () async {
                      Navigator.pop(context);
                      final Uri url = Uri(scheme: 'tel', path: phoneNumber);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCallOption(BuildContext context, {required IconData icon, required String label, required String sublabel, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(sublabel, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCancel(String alertId, BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Request?'),
        content: const Text('Are you sure you want to cancel this emergency request?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('NO')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('YES, CANCEL'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await Supabase.instance.client
          .from('emergency_alerts')
          .update({'status': 'cancelled'})
          .eq('id', alertId);
      if (context.mounted) Navigator.pop(context);
    }
  }

  void _showChatSheet(BuildContext context, WidgetRef ref, String alertId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ChatBottomSheet(alertId: alertId),
    );
  }
}

class _ChatBottomSheet extends ConsumerStatefulWidget {
  final String alertId;
  const _ChatBottomSheet({required this.alertId, super.key});

  @override
  ConsumerState<_ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends ConsumerState<_ChatBottomSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.alertId));
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.medical_services_rounded,
                    color: AppColors.info,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Medical Chat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('Active Consultation', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: messagesAsync.when(
              data: (messages) => ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: messages.length,
                reverse: false,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isMe = msg['sender_id'] == currentUserId;
                  return _buildMessage(context, msg['content'], isMe);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              left: 24,
              right: 24,
              top: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: const BoxDecoration(color: AppColors.info, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        ref.read(chatControllerProvider).sendMessage(widget.alertId, _controller.text);
                        _controller.clear();
                      }
                    },
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context, String content, bool isMe) {
    if (content.startsWith('---VIDEO_CALL_LINK---')) {
      final url = content.replaceFirst('---VIDEO_CALL_LINK---', '');
      return Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          width: 250,
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.videocam_rounded, color: Colors.amber),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('Video Consultation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
                  child: const Text('JOIN NOW', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isMe ? AppColors.info : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isMe ? const Radius.circular(20) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(20),
          ),
          boxShadow: [if (!isMe) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Text(
          content,
          style: TextStyle(
            color: isMe ? Colors.white : AppColors.textPrimary,
            fontSize: 15,
            fontWeight: isMe ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}