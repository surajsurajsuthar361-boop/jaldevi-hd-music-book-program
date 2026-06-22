
import 'package:flutter/material.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/booking/booking_form.dart';

class BookingScreen extends StatelessWidget {
  final Package package;

  const BookingScreen({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Session'),
      ),
      body: BookingForm(package: package),
    );
  }
}
