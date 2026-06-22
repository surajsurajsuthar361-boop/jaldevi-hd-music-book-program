import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/data/models/result.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/auth_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/admin/admin_dashboard_screen.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/booking/booking_history_screen.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/music_book/music_book_screen.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/packages/packages_screen.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/package_carousel.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/upcoming_booking_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jaldevi HD Music'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authNotifierProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UpcomingBookingCard(),
              const SizedBox(height: 24.0),
              Text('Our Packages', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16.0),
              const PackageCarousel(),
              const SizedBox(height: 16.0),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PackagesScreen()),
                        );
                      },
                      child: const Text('View All Packages'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BookingHistoryScreen()),
                        );
                      },
                      child: const Text('My Bookings'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MusicBookScreen()),
                        );
                      },
                      child: const Text('Music Book'),
                    ),
                    if (authState is Success<User?> &&
                        authState.data?.role == 'admin') ...[
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AdminDashboardScreen()),
                          );
                        },
                        child: const Text('Admin Dashboard'),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
