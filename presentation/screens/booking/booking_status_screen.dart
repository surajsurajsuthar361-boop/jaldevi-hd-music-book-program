import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/booking_status_notifier.dart';

class BookingStatusScreen extends ConsumerWidget {
  final String bookingId;

  const BookingStatusScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingStatusState = ref.watch(bookingStatusNotifierProvider(bookingId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Status'),
      ),
      body: bookingStatusState.when(
        data: (status) => Center(
          child: Text('Status: $status'),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
