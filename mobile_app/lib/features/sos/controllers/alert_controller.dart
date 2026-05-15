import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final latestAlertProvider = StreamProvider<Map<String, dynamic>?>((ref) async* {
  final client = Supabase.instance.client;
  final session = client.auth.currentSession;
  
  // Proactively refresh session if it's expired or near expiry
  if (session != null && session.isExpired) {
    try {
      await client.auth.refreshSession();
    } catch (e) {
      print('Session refresh error: $e');
    }
  }

  final user = client.auth.currentUser;
  if (user == null) {
    yield null;
    return;
  }

  yield* client
      .from('emergency_alerts')
      .stream(primaryKey: ['id'])
      .eq('user_id', user.id)
      .order('created_at', ascending: false)
      .limit(1)
      .map((data) => data.isNotEmpty ? data.first : null);
});

final historyAlertsProvider = StreamProvider<List<Map<String, dynamic>>>((ref) async* {
  final client = Supabase.instance.client;
  final session = client.auth.currentSession;
  
  if (session != null && session.isExpired) {
    try {
      await client.auth.refreshSession();
    } catch (e) {
      print('History session refresh error: $e');
    }
  }

  final user = client.auth.currentUser;
  if (user == null) {
    yield [];
    return;
  }

  yield* client
      .from('emergency_alerts')
      .stream(primaryKey: ['id'])
      .eq('user_id', user.id)
      .order('created_at', ascending: false);
});
