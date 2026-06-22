
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/booking_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/booking_state.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/booking_details_screen.dart';

class UpcomingBookingCard extends ConsumerWidget {
  const UpcomingBookingCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingNotifierProvider);

    // Fetch bookings when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookingNotifierProvider.notifier).fetchBookings();
    });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upcoming Booking', style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 16.0),
            _buildBody(context, bookingState),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BookingState state) {
    if (state is BookingLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is BookingSuccess) {
      final upcomingBooking = state.bookings.firstWhere(
        (booking) => booking.status == 'Upcoming',
        orElse: () => state.bookings.first,
      );
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(upcomingBooking.package.name),
            subtitle: Text('On ${upcomingBooking.eventDate.toLocal()}'.split(' ')[0]),
            trailing: Text(upcomingBooking.status, style: TextStyle(color: Colors.orange.shade700)),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookingDetailsScreen(booking: upcomingBooking),
                  ),
                );
              },
              child: const Text('View Details'),
            ),
          ),
        ],
      );
    } else if (state is BookingError) {
      return Center(child: Text(state.message));
    } else {
      return const Center(child: Text('Initial State'));
    }
  }
}
