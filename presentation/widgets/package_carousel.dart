
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/package_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/package_state.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/packages/package_details_screen.dart';

class PackageCarousel extends ConsumerWidget {
  const PackageCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageState = ref.watch(packageNotifierProvider);

    // Fetch packages when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(packageNotifierProvider.notifier).fetchPackages();
    });

    return SizedBox(
      height: 220,
      child: _buildBody(context, packageState),
    );
  }

  Widget _buildBody(BuildContext context, PackageState state) {
    if (state is PackageLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is PackageSuccess) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.packages.length,
        itemBuilder: (context, index) {
          final package = state.packages[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageDetailsScreen(package: package),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(package.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(package.name, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('₹${package.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else if (state is PackageError) {
      return Center(child: Text(state.message));
    } else {
      return const Center(child: Text('Initial State'));
    }
  }
}
