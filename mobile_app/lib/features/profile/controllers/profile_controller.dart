import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileControllerProvider = StateNotifierProvider<ProfileController, AsyncValue<Map<String, dynamic>?>>((ref) {
  return ProfileController();
});

class ProfileController extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  ProfileController() : super(const AsyncValue.loading()) {
    fetchProfile();
  }

  final _supabase = Supabase.instance.client;

  Future<void> fetchProfile() async {
    try {
      state = const AsyncValue.loading();
      final user = _supabase.auth.currentUser;
      if (user == null) {
        state = const AsyncValue.data(null);
        return;
      }

      final data = await _supabase
          .from('profiles')
          .select('*, emergency_contacts(*)')
          .eq('id', user.id)
          .single();

      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProfile({
    required String fullName,
    required String bloodGroup,
    required String allergies,
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return;

      await _supabase.from('profiles').update({
        'full_name': fullName,
        'blood_group': bloodGroup,
        'allergies': allergies,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', user.id);

      await fetchProfile();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addContact(String name, String phone, String relation) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return;

      await _supabase.from('emergency_contacts').insert({
        'user_id': user.id,
        'name': name,
        'phone': phone,
        'relation': relation,
      });

      await fetchProfile();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      await _supabase.from('emergency_contacts').delete().eq('id', id);
      await fetchProfile();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadAvatar(File imageFile) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return;

      final fileExt = imageFile.path.split('.').last;
      final fileName = '${user.id}.$fileExt';
      final path = 'avatars/$fileName';

      await _supabase.storage.from('avatars').upload(
            path,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );

      final imageUrl = _supabase.storage.from('avatars').getPublicUrl(path);

      await _supabase.from('profiles').update({
        'avatar_url': imageUrl,
      }).eq('id', user.id);

      await fetchProfile();
    } catch (e) {
      rethrow;
    }
  }
}
