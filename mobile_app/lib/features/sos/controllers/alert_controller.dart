import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final latestAlertProvider = StreamProvider<Map<String, dynamic>?>((ref) async* {
  final client = Supabase.instance.client;
  final session = client.auth.currentSession;
  
  // If session is expired, try to refresh. If refresh fails, sign out.
  if (session != null && session.isExpired) {
    try {
      await client.auth.refreshSession();
    } catch (e) {
      print('Session refresh failed, signing out: $e');
      await client.auth.signOut();
      yield null;
      return;
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
      print('History session refresh failed, signing out: $e');
      await client.auth.signOut();
      yield [];
      return;
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
