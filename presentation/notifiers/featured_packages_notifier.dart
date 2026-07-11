
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/package.dart';

abstract class FeaturedPackagesState {
  const FeaturedPackagesState();
}

class FeaturedPackagesInitial extends FeaturedPackagesState {
  const FeaturedPackagesInitial();
}

class FeaturedPackagesLoading extends FeaturedPackagesState {
  const FeaturedPackagesLoading();
}

class FeaturedPackagesSuccess extends FeaturedPackagesState {
  final List<Package> packages;

  const FeaturedPackagesSuccess(this.packages);
}

class FeaturedPackagesError extends FeaturedPackagesState {
  final String message;

  const FeaturedPackagesError(this.message);
}

final featuredPackagesNotifierProvider =
    StateNotifierProvider<FeaturedPackagesNotifier, FeaturedPackagesState>(
        (ref) {
  return FeaturedPackagesNotifier();
});

class FeaturedPackagesNotifier extends StateNotifier<FeaturedPackagesState> {
  FeaturedPackagesNotifier() : super(const FeaturedPackagesInitial());

  Future<void> fetchFeaturedPackages() async {
    state = const FeaturedPackagesLoading();
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
          includedEquipment: ['DJ Deck', 'Speakers', 'Lights'],
          includedStaff: ['DJ'],
        ),
        Package(
          id: 'package-3',
          name: 'Acoustic Duo',
          description: 'An acoustic duo for a more intimate setting.',
          price: 15000,
          imageUrl: 'https://via.placeholder.com/150',
          includedEquipment: ['Acoustic Guitars', 'Microphones', 'Small PA'],
          includedStaff: ['2 Musicians'],
        ),
      ];
      state = FeaturedPackagesSuccess(packages);
    } catch (e) {
      state = FeaturedPackagesError(e.toString());
    }
  }
}
