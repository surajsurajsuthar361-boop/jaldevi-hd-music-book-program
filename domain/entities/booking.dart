'''import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';

class Booking {
  final String id;
  final User user;
  final Package package;
  final DateTime date;
  final String status;
  final double totalPrice;

  Booking({
    required this.id,
    required this.user,
    required this.package,
    required this.date,
    required this.status,
    required this.totalPrice,
  });

  static Booking empty = Booking(
    id: '',
    user: User.fromFirestore(const DocumentSnapshot.internal(data: {}, id: '')),
    package: Package.empty,
    date: DateTime.now(),
    status: '',
    totalPrice: 0.0,
  );

  Booking copyWith({
    String? id,
    User? user,
    Package? package,
    DateTime? date,
    String? status,
    double? totalPrice,
  }) {
    return Booking(
      id: id ?? this.id,
      user: user ?? this.user,
      package: package ?? this.package,
      date: date ?? this.date,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': user.id,
      'packageId': package.id,
      'date': Timestamp.fromDate(date),
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Booking.fromFirestore(DocumentSnapshot doc, User user, Package package) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Booking(
      id: doc.id,
      user: user,
      package: package,
      date: (data['date'] as Timestamp).toDate(),
      status: data['status'] ?? '',
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
    );
  }
}
''