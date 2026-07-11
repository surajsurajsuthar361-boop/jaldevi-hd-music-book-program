
import 'package:flutter/material.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/featured_packages_list.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/upcoming_bookings_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jaldevi HD Music'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Featured Packages', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            FeaturedPackagesList(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Upcoming Bookings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            UpcomingBookingsList(),
          ],
        ),
      ),
    );
  }
}
