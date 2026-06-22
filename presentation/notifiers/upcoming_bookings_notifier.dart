
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/booking.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';

abstract class UpcomingBookingsState {
  const UpcomingBookingsState();
}

class UpcomingBookingsInitial extends UpcomingBookingsState {
  const UpcomingBookingsInitial();
}

class UpcomingBookingsLoading extends UpcomingBookingsState {
  const UpcomingBookingsLoading();
}

class UpcomingBookingsSuccess extends UpcomingBookingsState {
  final List<Booking> bookings;

  const UpcomingBookingsSuccess(this.bookings);
}

class UpcomingBookingsError extends UpcomingBookingsState {
  final String message;

  const UpcomingBookingsError(this.message);
}

final upcomingBookingsNotifierProvider = StateNotifierProvider<UpcomingBookingsNotifier, UpcomingBookingsState>((ref) {
  return UpcomingBookingsNotifier();
});

class UpcomingBookingsNotifier extends StateNotifier<UpcomingBookingsState> {
  UpcomingBookingsNotifier() : super(const UpcomingBookingsInitial());

  Future<void> fetchUpcomingBookings() async {
    state = const UpcomingBookingsLoading();
    try {
      // In a real app, you would fetch this from a service.
      final bookings = [
        Booking(
          id: 'booking-1',
          package: Package(
            id: 'package-1',
            name: 'Live Band',
            description: 'A full live band for your event.',
            price: 50000,
            imageUrl: 'https://via.placeholder.com/150',
            includedEquipment: ['Sound System', 'Microphones', 'Lights'],
            includedStaff: ['Sound Engineer', 'Lighting Technician'],
          ),
          user: User(id: 'user-1', name: 'John Doe', email: 'john.doe@example.com', phone: '1234567890'),
          eventDate: DateTime.now().add(const Duration(days: 10)),
          eventVenue: 'Community Hall',
          eventType: 'Wedding',
          status: 'Upcoming',
        ),
      ];
      state = UpcomingBookingsSuccess(bookings);
    } catch (e) {
      state = UpcomingBookingsError(e.toString());
    }
  }
}
