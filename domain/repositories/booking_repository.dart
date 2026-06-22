import 'package:jaldevi_hd_music_book_program/domain/entities/booking.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';

abstract class BookingRepository {
  Future<List<Booking>> getBookings();
  Future<Booking> getBookingById(String id);
  Future<void> createBooking(Package package, DateTime eventDate);
}
