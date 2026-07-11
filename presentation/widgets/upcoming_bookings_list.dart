
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/upcoming_bookings_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/upcoming_booking_card.dart';

class UpcomingBookingsList extends ConsumerStatefulWidget {
  const UpcomingBookingsList({super.key});

  @override
  ConsumerState<UpcomingBookingsList> createState() => _UpcomingBookingsListState();
}

class _UpcomingBookingsListState extends ConsumerState<UpcomingBookingsList> {
  @override
  void initState() {
    super.initState();
    // Call fetchUpcomingBookings when the widget is first initialized.
    ref.read(upcomingBookingsNotifierProvider.notifier).fetchUpcomingBookings();
  }

  @override
  Widget build(BuildContext context) {
    final upcomingBookingsState = ref.watch(upcomingBookingsNotifierProvider);

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
