
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/data/data.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/booking_state.dart';

final bookingNotifierProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) {
  return BookingNotifier();
});

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier() : super(const BookingInitial());

  Future<void> fetchBookings() async {
    state = const BookingLoading();
    try {
      // In a real app, you would fetch this data from a service.
      final bookings = AppData.bookings;
      state = BookingSuccess(bookings);
    } catch (e) {
      state = BookingError(e.toString());
    }
  }
}
