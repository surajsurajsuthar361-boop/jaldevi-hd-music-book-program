
import 'package:flutter/material.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/featured_packages.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/upcoming_bookings_list.dart';

class HomeContent extends StatelessWidget {
  final VoidCallback onViewAllPackages;

  const HomeContent({super.key, required this.onViewAllPackages});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Search Bar
        TextField(
          decoration: InputDecoration(
            hintText: 'Search for packages...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        const SizedBox(height: 24.0),

        // Upcoming Bookings Section
        Text(
          'Upcoming Bookings',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 200, // Adjust height as needed
          child: const UpcomingBookingsList(),
        ),
        const SizedBox(height: 24.0),

        // Featured Packages Section
        Text(
          'Featured Packages',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 16.0),
        const FeaturedPackages(),
        const SizedBox(height: 24.0),

        // View All Packages Button
        ElevatedButton(
          onPressed: onViewAllPackages,
          child: const Text('View All Packages'),
        ),
      ],
    );
  }
}
