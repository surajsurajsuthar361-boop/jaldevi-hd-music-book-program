import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/booking.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';

// Provider for the BookingService
final bookingServiceProvider = Provider<BookingService>((ref) => BookingService());

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _packagesCollection = FirebaseFirestore.instance.collection('packages');

  // Creates a new booking in Firestore.
  Future<void> createBooking(Booking booking) async {
    try {
      await _firestore.collection('bookings').add(booking.toFirestore());
    } catch (e) {
      print('Error creating booking: $e');
      rethrow;
    }
  }

  // Fetches a user's bookings from Firestore.
  Future<List<Booking>> getBookings(String userId) async {
    try {
      final bookingSnapshots = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('eventDate', descending: true)
          .get();

      if (bookingSnapshots.docs.isEmpty) {
        return [];
      }

      // Efficiently fetch all required packages in a single query
      final packageIds = bookingSnapshots.docs
          .map((doc) => doc.data()['packageId'] as String)
          .toSet()
          .toList();
          
      final packageSnapshots = await _packagesCollection
          .where(FieldPath.documentId, whereIn: packageIds)
          .get();
          
      final packages = packageSnapshots.docs.map((doc) => Package.fromFirestore(doc)).toList();
      final packageMap = {for (var p in packages) p.id: p};

      // Combine bookings with their packages
      final bookings = bookingSnapshots.docs.map((doc) {
        final packageId = doc.data()['packageId'] as String;
        final package = packageMap[packageId];
        if (package != null) {
          return Booking.fromFirestore(doc, package);
        } else {
          // Handle cases where a package might be missing
          return null;
        }
      }).whereType<Booking>().toList(); // Filter out nulls

      return bookings;
    } catch (e) {
      print('Error fetching bookings: $e');
      rethrow;
    }
  }
}
