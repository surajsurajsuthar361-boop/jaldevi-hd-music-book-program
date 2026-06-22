
import 'package:flutter/material.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/booking.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Booking booking;

  const BookingDetailsScreen({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Package: ${booking.package.name}', style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8.0),
            Text('Date: ${booking.eventDate.toLocal()}'.split(' ')[0]),
            const SizedBox(height: 8.0),
            Text('Status: ${booking.status}'),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Text('Client Name: ${booking.clientName}'),
            const SizedBox(height: 8.0),
            Text('Client Email: ${booking.clientEmail}'),
            const SizedBox(height: 8.0),
            Text('Client Phone: ${booking.clientPhone}'),
            const SizedBox(height: 8.0),
            Text('Event Address: ${booking.eventAddress}'),
          ],
        ),
      ),
    );
  }
}
