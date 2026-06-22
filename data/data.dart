
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/booking.dart';

class AppData {
  static final List<Package> packages = [
    Package(
      id: '1',
      name: 'Solo Singer',
      description: 'A captivating solo performance for intimate gatherings.',
      price: 5000,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Package(
      id: '2',
      name: 'Acoustic Duo',
      description: 'An acoustic duo playing a mix of popular songs.',
      price: 10000,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Package(
      id: '3',
      name: 'Full Band',
      description: 'A five-piece band to get your party started.',
      price: 25000,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Package(
      id: '4',
      name: 'DJ Night',
      description: 'A professional DJ playing the latest tracks.',
      price: 15000,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  static final List<Booking> bookings = [
    Booking(
      id: '1',
      package: packages[0],
      eventDate: DateTime(2024, 8, 15),
      status: 'Upcoming',
    ),
    Booking(
      id: '2',
      package: packages[2],
      eventDate: DateTime(2024, 6, 20),
      status: 'Completed',
    ),
    Booking(
      id: '3',
      package: packages[1],
      eventDate: DateTime(2024, 5, 10),
      status: 'Cancelled',
    ),
  ];
}
