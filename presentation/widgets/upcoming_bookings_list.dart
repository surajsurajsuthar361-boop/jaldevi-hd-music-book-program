
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/upcoming_bookings_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/upcoming_booking_card.dart';

class UpcomingBookingsList extends ConsumerWidget {
  const UpcomingBookingsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingBookingsState = ref.watch(upcomingBookingsNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(upcomingBookingsNotifierProvider.notifier).fetchUpcomingBookings();
    });

    return switch (upcomingBookingsState) {
      UpcomingBookingsInitial() => const Center(child: Text('Initial State')),
      UpcomingBookingsLoading() => const Center(child: CircularProgressIndicator()),
      UpcomingBookingsSuccess(bookings: final bookings) => ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            final booking = bookings[index];
            return UpcomingBookingCard(booking: booking);
          },
        ),
      UpcomingBookingsError(message: final message) => Center(child: Text(message)),
    };
  }
}
