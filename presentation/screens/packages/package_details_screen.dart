import 'package:flutter/material.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/booking/booking_screen.dart';

class PackageDetailsScreen extends StatelessWidget {
  final Package package;

  const PackageDetailsScreen({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(package.name),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: package.id, // Ensure your package list uses this tag too
              child: Image.network(
                package.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Center(child: Icon(Icons.broken_image, size: 100, color: Colors.grey)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    package.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '₹${package.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const SizedBox(height: 16.0),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(package.description, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 24.0),
                  _buildSectionList('Included Equipment', package.includedEquipment, Icons.build, context),
                  const SizedBox(height: 24.0),
                  _buildSectionList('Included Staff', package.includedStaff, Icons.people, context),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingScreen(package: package),
              ),
            );
          },
          icon: const Icon(Icons.date_range),
          label: const Text('Book Now'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionList(String title, List<String> items, IconData icon, BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            children: [
              Icon(icon, size: 16, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8.0),
              Expanded(child: Text(item, style: Theme.of(context).textTheme.bodyLarge)),
            ],
          ),
        )).toList(),
      ],
    );
  }
}
