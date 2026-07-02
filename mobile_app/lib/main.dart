import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/welcome_screen.dart';
import 'features/sos/screens/sos_home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants/supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

  final session = Supabase.instance.client.auth.currentSession;
  if (session != null && session.isExpired) {
    try {
      // Attempt refresh but don't block the UI if it takes too long
      // Actually, Supabase handles refreshing internally when you make requests, 
      // but we do it here once to be sure.
      await Supabase.instance.client.auth.refreshSession();
      print('--- Supabase Auth: Session refreshed at startup ---');
    } catch (_) {
      // If refresh fails, we'll let the routing logic handle it or 
      // let the user try to perform an action which will then trigger logout.
      print('--- Supabase Auth: Refresh failed at startup ---');
    }
  }

  // Listen to auth state changes for debugging
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;
    if (event == AuthChangeEvent.tokenRefreshed) {
      print('--- Supabase Auth: Token Refreshed ---');
    } else if (event == AuthChangeEvent.signedOut) {
      print('--- Supabase Auth: Signed Out ---');
    }
  });

  runApp(
    const ProviderScope(
      child: NileEmergencyApp(),
    ),
  );
}

class NileEmergencyApp extends StatelessWidget {
  const NileEmergencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    // Persist login if session exists (even if expired, it might be refreshable)
    final isLoggedIn = session != null;
    return MaterialApp(
      title: 'Nile Emergency',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: isLoggedIn ? const SOSHomeScreen() : const WelcomeScreen(),
    );
  }
}
