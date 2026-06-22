
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';

abstract class PackageState {
  const PackageState();
}

class PackageInitial extends PackageState {
  const PackageInitial();
}

class PackageLoading extends PackageState {
  const PackageLoading();
}

class PackageSuccess extends PackageState {
  final List<Package> packages;

  const PackageSuccess(this.packages);
}

class PackageError extends PackageState {
  final String message;

  const PackageError(this.message);
}

final packageNotifierProvider = StateNotifierProvider<PackageNotifier, PackageState>((ref) {
  return PackageNotifier();
});

class PackageNotifier extends StateNotifier<PackageState> {
  PackageNotifier() : super(const PackageInitial());

  Future<void> fetchPackages() async {
    state = const PackageLoading();
    try {
      // In a real app, you would fetch this from a service.
      final packages = [
        Package(
          id: 'package-1',
          name: 'Live Band',
          description: 'A full live band for your event.',
          price: 50000,
          imageUrl: 'https://via.placeholder.com/150',
          includedEquipment: ['Sound System', 'Microphones', 'Lights'],
          includedStaff: ['Sound Engineer', 'Lighting Technician'],
        ),
        Package(
          id: 'package-2',
          name: 'DJ',
          description: 'A professional DJ for your event.',
          price: 25000,
          imageUrl: 'https://via.placeholder.com/150',
          includedEquipment: ['DJ Controller', 'Speakers', 'Lights'],
          includedStaff: ['DJ'],
        ),
        Package(
          id: 'package-3',
          name: 'Acoustic Duo',
          description: 'An acoustic duo for a more intimate setting.',
          price: 15000,
          imageUrl: 'https://via.placeholder.com/150',
          includedEquipment: ['Acoustic Guitars', 'Small PA System'],
          includedStaff: ['2 Musicians'],
        ),
      ];
      state = PackageSuccess(packages);
    } catch (e) {
      state = PackageError(e.toString());
    }
  }
}
