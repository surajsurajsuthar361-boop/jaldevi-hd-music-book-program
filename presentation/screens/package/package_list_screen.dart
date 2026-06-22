import 'package:flutter/material.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/booking/booking_form_screen.dart';

class PackageListScreen extends StatelessWidget {
  const PackageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Package> packages = [
      Package(
        id: '1',
        name: 'Solo Singer',
        description: 'A captivating solo performance for intimate gatherings.',
        price: 5000,
        imageUrl: 'https://via.placeholder.com/150',
      ),
      Package(
        id: '2',
        name: 'Acoustic Duo',
        description: 'An acoustic duo playing a mix of popular songs.',
        price: 10000,
        imageUrl: 'https://via.placeholder.com/150',
      ),
      Package(
        id: '3',
        name: 'Full Band',
        description: 'A five-piece band to get your party started.',
        price: 25000,
        imageUrl: 'https://via.placeholder.com/150',
      ),
      Package(
        id: '4',
        name: 'DJ Night',
        description: 'A professional DJ playing the latest tracks.',
        price: 15000,
        imageUrl: 'https://via.placeholder.com/150',
      ),
    ];

    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final package = packages[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(package.imageUrl),
                const SizedBox(height: 16.0),
                Text(package.name, style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 8.0),
                Text(package.description),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹${package.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headline6),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingFormScreen(package: package),
                          ),
                        );
                      },
                      child: const Text('Book Now'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
