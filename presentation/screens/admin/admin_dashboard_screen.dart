
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/music_book_notifier.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/music_book_state.dart';
import 'package:jaldevi_hd_music_book_program/presentation/screens/admin/add_edit_entry_screen.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

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
        title: const Text('Admin Dashboard'),
      ),
      body: _buildBody(context, musicBookState, musicBookNotifier),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddEditEntryScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context, MusicBookState state, MusicBookNotifier notifier) {
    if (state is MusicBookLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MusicBookSuccess) {
      return ListView.builder(
        itemCount: state.entries.length,
        itemBuilder: (context, index) {
          final entry = state.entries[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(entry.title),
              subtitle: Text('${entry.artist} - ${entry.album}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddEditEntryScreen(entry: entry),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Entry'),
                          content: const Text('Are you sure you want to delete this entry?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                notifier.deleteMusicBookEntry(entry.id);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (state is MusicBookError) {
      return Center(child: Text(state.message));
    } else {
      return const Center(child: Text('Initial State'));
    }
  }
}
