
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/data/services/music_book_service.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/music_book_entry.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/music_book_state.dart';

final musicBookNotifierProvider = StateNotifierProvider<MusicBookNotifier, MusicBookState>((ref) {
  return MusicBookNotifier(MusicBookService());
});

class MusicBookNotifier extends StateNotifier<MusicBookState> {
  final MusicBookService _musicBookService;

  MusicBookNotifier(this._musicBookService) : super(const MusicBookInitial());

  Future<void> fetchMusicBook() async {
    state = const MusicBookLoading();
    try {
      final entries = await _musicBookService.getMusicBookEntries();
      state = MusicBookSuccess(entries, entries);
    } catch (e) {
      state = MusicBookError(e.toString());
    }
  }

  void search(String query) {
    final currentState = state;
    if (currentState is MusicBookSuccess) {
      final filteredEntries = currentState.entries.where((entry) {
        final lowerCaseQuery = query.toLowerCase();
        return entry.title.toLowerCase().contains(lowerCaseQuery) ||
            entry.artist.toLowerCase().contains(lowerCaseQuery) ||
            entry.album.toLowerCase().contains(lowerCaseQuery);
      }).toList();
      state = MusicBookSuccess(currentState.entries, filteredEntries);
    }
  }

  Future<void> addMusicBookEntry(MusicBookEntry entry) async {
    try {
      await _musicBookService.addMusicBookEntry(entry);
      await fetchMusicBook(); // Refresh the list
    } catch (e) {
      state = MusicBookError(e.toString());
    }
  }

  Future<void> updateMusicBookEntry(MusicBookEntry entry) async {
    try {
      await _musicBookService.updateMusicBookEntry(entry);
      await fetchMusicBook(); // Refresh the list
    } catch (e) {
      state = MusicBookError(e.toString());
    }
  }

  Future<void> deleteMusicBookEntry(String id) async {
    try {
      await _musicBookService.deleteMusicBookEntry(id);
      await fetchMusicBook(); // Refresh the list
    } catch (e) {
      state = MusicBookError(e.toString());
    }
  }
}
