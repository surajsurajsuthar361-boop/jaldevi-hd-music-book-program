import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';

// Provider for the PackageService
final packageServiceProvider = Provider<PackageService>((ref) => PackageService());

class PackageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetches all packages from the 'packages' collection in Firestore.
  Future<List<Package>> getPackages() async {
    try {
      final snapshot = await _firestore.collection('packages').get();
      // To use fromFirestore, I need to see the Package entity definition first.
      // Assuming it has a fromFirestore method.
      return snapshot.docs.map((doc) => Package.fromFirestore(doc)).toList();
    } catch (e) {
      // In a real app, you'd have more robust error handling.
      print(e);
      rethrow;
    }
  }
}
