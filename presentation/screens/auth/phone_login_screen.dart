import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/auth_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/home/home_screen.dart';

class PhoneLoginScreen extends ConsumerWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = TextEditingController();
    final otpController = TextEditingController();

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
      if (next is AuthSuccess) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });

    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '+1 650-555-1234', // Example hint
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            if (authState is AuthLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).sendOTP(phoneController.text);
                },
                child: const Text('Send OTP'),
              ),
            if (authState is AuthPhoneCodeSentSuccess) ...[
              const SizedBox(height: 16),
              TextField(
                controller: otpController,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(authNotifierProvider.notifier)
                      .verifyOTP(otpController.text);
                },
                child: const Text('Verify OTP'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
