import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final sosServiceProvider = Provider((ref) => SOSService());

class SOSService {
  final _supabase = Supabase.instance.client;

  Future<void> triggerSOS({
    required String category,
    required String severity,
    String location = 'Nile Campus',
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    // Get current position (with permission handling)
    Position? position;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
          position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
        }
      }
    } catch (e) {
      print('Location error: $e');
    }

    // Ensure profile row exists to satisfy foreign key constraints
    final profileExists = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (profileExists == null) {
      await _supabase.from('profiles').upsert({
        'id': user.id,
        'full_name': user.email?.split('@')[0] ?? 'User', 
        'updated_at': DateTime.now().toIso8601String(),
      }, onConflict: 'id');
    }

    await _supabase.from('emergency_alerts').insert({
      'user_id': user.id,
      'category': category,
      'severity': severity,
      'location': location, 
      'latitude': position?.latitude,
      'longitude': position?.longitude,
      'status': 'pending',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Stream<List<Map<String, dynamic>>> getMyAlerts() {
    final user = _supabase.auth.currentUser;
    if (user == null) return const Stream.empty();
    
    return _supabase
        .from('emergency_alerts')
        .stream(primaryKey: ['id'])
        .eq('user_id', user.id)
        .order('created_at');
  }
}
