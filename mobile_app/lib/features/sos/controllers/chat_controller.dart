import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatMessagesProvider = StreamProvider.family<List<Map<String, dynamic>>, String>((ref, alertId) {
  final supabase = Supabase.instance.client;
  return supabase
      .from('emergency_messages')
      .stream(primaryKey: ['id'])
      .eq('alert_id', alertId)
      .order('created_at', ascending: true);
});

class ChatController {
  final _supabase = Supabase.instance.client;

  Future<void> sendMessage(String alertId, String content) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('emergency_messages').insert({
      'alert_id': alertId,
      'sender_id': user.id,
      'content': content,
    });
  }
}

final chatControllerProvider = Provider((ref) => ChatController());
