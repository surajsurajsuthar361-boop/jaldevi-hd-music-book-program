import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/package_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/packages/package_details_screen.dart';

class PackagesScreen extends ConsumerWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packagesState = ref.watch(packageNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Packages'),
      ),
      body: packagesState.when(
        initial: () => const Center(child: Text('Initializing...')),
        loading: () => const Center(child: CircularProgressIndicator()),
        success: (packages) {
          if (packages.isEmpty) {
            return const Center(child: Text('No packages found.'));
          }
          return ListView.builder(
            itemCount: packages.length,
            itemBuilder: (context, index) {
              final package = packages[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: package.imageUrl.isNotEmpty
                      ? Image.network(
                          package.imageUrl,
                          width: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.music_note, size: 40),
                        )
                      : const Icon(Icons.music_note, size: 40),
                  title: Text(package.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    '₹${package.price.toStringAsFixed(2)}',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PackageDetailsScreen(package: package),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => ref.read(packageNotifierProvider.notifier).getPackages(),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
