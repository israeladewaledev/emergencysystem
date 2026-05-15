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

  // Listen to auth state changes for proactive session management
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;
    final Session? session = data.session;
    
    if (event == AuthChangeEvent.tokenRefreshed) {
      print('--- Supabase Auth: Token Refreshed Successfully ---');
    } else if (event == AuthChangeEvent.signedOut) {
      print('--- Supabase Auth: User Signed Out ---');
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
    return MaterialApp(
      title: 'Nile Emergency',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Supabase.instance.client.auth.currentSession != null 
          ? const SOSHomeScreen() 
          : const WelcomeScreen(),
    );
  }
}
