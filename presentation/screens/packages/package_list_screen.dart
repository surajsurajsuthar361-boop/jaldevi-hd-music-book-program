
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/package_notifier.dart';

class PackageListScreen extends ConsumerWidget {
  const PackageListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageState = ref.watch(packageNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Packages'),
      ),
      body: packageState.when(
        data: (packages) => ListView.builder(
          itemCount: packages.length,
          itemBuilder: (context, index) {
            final package = packages[index];
            return ListTile(
              title: Text(package.name),
              subtitle: Text(package.description),
              onTap: () {
                // Navigate to package details screen
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
