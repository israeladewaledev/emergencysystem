import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final latestAlertProvider = StreamProvider<Map<String, dynamic>?>((ref) {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return Stream.value(null);

  return Supabase.instance.client
      .from('emergency_alerts')
      .stream(primaryKey: ['id'])
      .eq('user_id', user.id)
      .order('created_at', ascending: false)
      .limit(1)
      .map((data) => data.isNotEmpty ? data.first : null);
});

final historyAlertsProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return Stream.value([]);

  return Supabase.instance.client
      .from('emergency_alerts')
      .stream(primaryKey: ['id'])
      .eq('user_id', user.id)
      .order('created_at', ascending: false);
});
