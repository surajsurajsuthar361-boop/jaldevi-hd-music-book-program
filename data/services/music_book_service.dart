
import 'package:jaldevi_hd_music_book_program/domain/entities/music_book_entry.dart';
import 'package:jaldevi_hd_music_book_program/domain/repositories/music_book_repository.dart';

class MusicBookService implements MusicBookRepository {
  List<MusicBookEntry> _entries = [
    MusicBookEntry(id: '1', title: 'Song 1', artist: 'Artist 1', album: 'Album 1', genre: 'Genre 1', year: 2021),
    MusicBookEntry(id: '2', title: 'Song 2', artist: 'Artist 2', album: 'Album 2', genre: 'Genre 2', year: 2022),
    MusicBookEntry(id: '3', title: 'Song 3', artist: 'Artist 3', album: 'Album 3', genre: 'Genre 3', year: 2023),
  ];

  @override
  Future<List<MusicBookEntry>> getMusicBookEntries() async {
    // In a real app, you would fetch this data from a database or API.
    return Future.delayed(const Duration(seconds: 1), () => _entries);
  }

  @override
  Future<void> addMusicBookEntry(MusicBookEntry entry) async {
    // In a real app, you would insert this into a database.
    _entries.add(entry);
  }

  @override
  Future<void> updateMusicBookEntry(MusicBookEntry entry) async {
    // In a real app, you would update this in a database.
    final index = _entries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      _entries[index] = entry;
    }
  }

  @override
  Future<void> deleteMusicBookEntry(String id) async {
    // In a real app, you would delete this from a database.
    _entries.removeWhere((e) => e.id == id);
  }
}
