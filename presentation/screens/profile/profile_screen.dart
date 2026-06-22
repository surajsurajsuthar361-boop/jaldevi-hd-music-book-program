import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // User Info Header
        CircleAvatar(
          radius: 50,
          // You can add a user's profile picture here
          child: const Icon(Icons.person, size: 50),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Text(
            user?.phoneNumber ?? 'No phone number',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(height: 24.0),

        // Profile Options
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Edit Profile'),
          onTap: () {
            // TODO: Navigate to an edit profile screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            // TODO: Navigate to a settings screen
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Logout', style: TextStyle(color: Colors.red)),
          onTap: () {
            ref.read(authNotifierProvider.notifier).logout();
          },
        ),
      ],
    );
  }
}
