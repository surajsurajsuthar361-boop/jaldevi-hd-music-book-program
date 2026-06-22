import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/firebase_options.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/auth_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/auth/login_screen.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: 'Jaldevi HD Music Book Program',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: authState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        success: (user) => user != null ? const HomeScreen() : const LoginScreen(),
        error: (message) => const LoginScreen(),
      ),
    );
  }
}
