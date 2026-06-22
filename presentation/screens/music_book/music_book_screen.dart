
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/music_book_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/music_book_state.dart';

class MusicBookScreen extends ConsumerWidget {
  const MusicBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final musicBookState = ref.watch(musicBookNotifierProvider);
    final musicBookNotifier = ref.read(musicBookNotifierProvider.notifier);

    // Fetch the music book when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      musicBookNotifier.fetchMusicBook();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Book'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by title, artist, or album',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                musicBookNotifier.search(value);
              },
            ),
          ),
          Expanded(child: _buildBody(musicBookState)),
        ],
      ),
    );
  }

  Widget _buildBody(MusicBookState state) {
    if (state is MusicBookLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MusicBookSuccess) {
      return ListView.builder(
        itemCount: state.filteredEntries.length,
        itemBuilder: (context, index) {
          final entry = state.filteredEntries[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.music_note),
              title: Text(entry.title),
              subtitle: Text('${entry.artist} - ${entry.album}'),
              trailing: Text(entry.year.toString()),
            ),
          );
        },
      );
    } else if (state is MusicBookError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 10),
            Text(state.message, style: const TextStyle(color: Colors.red)),
          ],
        ),
      );
    } else {
      return const Center(child: Text('Press the button to fetch the music book.'));
    }
  }
}
