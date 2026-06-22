import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/data/models/result.dart';
import 'package:jaldevi_hd_music_book_program/data/services/booking_service.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/booking.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Provider for the BookingHistoryNotifier
final bookingHistoryNotifierProvider = StateNotifierProvider<BookingHistoryNotifier, Result<List<Booking>>>((ref) {
  return BookingHistoryNotifier(ref.watch(bookingServiceProvider));
});

class BookingHistoryNotifier extends StateNotifier<Result<List<Booking>>> {
  final BookingService _bookingService;

  BookingHistoryNotifier(this._bookingService) : super(const Result.initial()) {
    fetchBookingHistory();
  }

  Future<void> fetchBookingHistory() async {
    state = const Result.loading();
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in.');
      }
      final bookings = await _bookingService.getBookings(user.uid);
      state = Result.success(bookings);
    } catch (e) {
      state = Result.error('Could not fetch booking history: ${e.toString()}');
    }
  }
}
