
import 'package:jaldevi_hd_music_book_program/domain/entities/music_book_entry.dart';

abstract class MusicBookState {
  const MusicBookState();
}

class MusicBookInitial extends MusicBookState {
  const MusicBookInitial();
}

class MusicBookLoading extends MusicBookState {
  const MusicBookLoading();
}

class MusicBookSuccess extends MusicBookState {
  final List<MusicBookEntry> entries;
  final List<MusicBookEntry> filteredEntries;

  const MusicBookSuccess(this.entries, this.filteredEntries);
}

class MusicBookError extends MusicBookState {
  final String message;
  const MusicBookError(this.message);
}
