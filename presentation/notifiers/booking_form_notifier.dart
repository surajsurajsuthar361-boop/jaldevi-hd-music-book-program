
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/booking.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';

abstract class BookingFormState {
  const BookingFormState();
}

class BookingFormInitial extends BookingFormState {
  const BookingFormInitial();
}

class BookingFormLoading extends BookingFormState {
  const BookingFormLoading();
}

class BookingFormSuccess extends BookingFormState {
  final Booking booking;

  const BookingFormSuccess(this.booking);
}

class BookingFormError extends BookingFormState {
  final String message;

  const BookingFormError(this.message);
}

final bookingFormNotifierProvider = StateNotifierProvider<BookingFormNotifier, BookingFormState>((ref) {
  return BookingFormNotifier();
});

class BookingFormNotifier extends StateNotifier<BookingFormState> {
  BookingFormNotifier() : super(const BookingFormInitial());

  Future<void> createBooking({
    required Package package,
    required User user,
    required DateTime eventDate,
    required String eventVenue,
    required String eventType,
  }) async {
    state = const BookingFormLoading();
    try {
      // In a real app, you would send this to a service to be saved.
      final booking = Booking(
        id: 'booking-${DateTime.now().millisecondsSinceEpoch}',
        package: package,
        user: user,
        eventDate: eventDate,
        eventVenue: eventVenue,
        eventType: eventType,
        status: 'Upcoming',
      );
      state = BookingFormSuccess(booking);
    } catch (e) {
      state = BookingFormError(e.toString());
    }
  }
}
