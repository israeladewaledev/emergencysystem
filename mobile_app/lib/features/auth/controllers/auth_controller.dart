import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = Provider((ref) => AuthController());

class AuthController {
  final _supabase = Supabase.instance.client;

  Future<void> signUp({
    required String fullName,
    required String studentId,
    required String bloodGroup,
    required String allergies,
    required String password,
  }) async {
    try {
      // 1. Create Auth User (sanitize student ID to remove slashes/spaces for email)
      final sanitizedId = studentId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
      final email = '$sanitizedId@nile.edu.ng';
      
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = res.user;
      if (user == null) throw 'Registration failed: No user created';

      // 2. Insert into Profiles Table
      await _supabase.from('profiles').insert({
        'id': user.id,
        'full_name': fullName,
        'student_id': studentId, // Keep original ID here
        'blood_group': bloodGroup,
        'allergies': allergies,
        'updated_at': DateTime.now().toIso8601String(),
      });

    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signIn({required String studentId, required String password}) async {
     final sanitizedId = studentId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
     final email = '$sanitizedId@nile.edu.ng';
     await _supabase.auth.signInWithPassword(email: email, password: password);
  }
}
