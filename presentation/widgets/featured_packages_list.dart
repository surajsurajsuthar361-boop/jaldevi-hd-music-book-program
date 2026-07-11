
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/featured_packages_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/featured_package_card.dart';

class FeaturedPackagesList extends ConsumerStatefulWidget {
  const FeaturedPackagesList({super.key});

  @override
  ConsumerState<FeaturedPackagesList> createState() => _FeaturedPackagesListState();
}

class _FeaturedPackagesListState extends ConsumerState<FeaturedPackagesList> {
  @override
  void initState() {
    super.initState();
    ref.read(featuredPackagesNotifierProvider.notifier).fetchFeaturedPackages();
  }

  @override
  Widget build(BuildContext context) {
    final featuredPackagesState = ref.watch(featuredPackagesNotifierProvider);

    return switch (featuredPackagesState) {
      FeaturedPackagesInitial() => const Center(child: Text('Initial State')),
      FeaturedPackagesLoading() => const Center(child: CircularProgressIndicator()),
      FeaturedPackagesSuccess(packages: final packages) => SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: packages.length,
            itemBuilder: (context, index) {
              final package = packages[index];
              return FeaturedPackageCard(package: package);
            },
          ),
        ),
      FeaturedPackagesError(message: final message) => Center(child: Text(message)),
    };
  }
}
