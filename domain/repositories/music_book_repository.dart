
import 'package:jaldevi_hd_music_book_program/domain/entities/music_book_entry.dart';

abstract class MusicBookRepository {
  Future<List<MusicBookEntry>> getMusicBookEntries();
  Future<void> addMusicBookEntry(MusicBookEntry entry);
  Future<void> updateMusicBookEntry(MusicBookEntry entry);
  Future<void> deleteMusicBookEntry(String id);
}
