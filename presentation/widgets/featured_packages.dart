
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/package_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/package_details/package_details_screen.dart';
import 'package:jaldevi_hd_music_book_program/presentation/widgets/package_card.dart';

class FeaturedPackages extends ConsumerWidget {
  const FeaturedPackages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageState = ref.watch(packageNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(packageNotifierProvider.notifier).fetchPackages();
    });

    return switch (packageState) {
      PackageInitial() => const Center(child: Text('Initial State')),
      PackageLoading() => const Center(child: CircularProgressIndicator()),
      PackageSuccess(packages: final packages) => SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: packages.length,
            itemBuilder: (context, index) {
              final package = packages[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PackageDetailsScreen(package: package),
                    ),
                  );
                },
                child: PackageCard(package: package),
              );
            },
          ),
        ),
      PackageError(message: final message) => Center(child: Text(message)),
    };
  }
}
