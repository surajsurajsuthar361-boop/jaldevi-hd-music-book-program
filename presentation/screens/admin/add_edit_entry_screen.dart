
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/music_book_entry.dart';
import 'package:jaldevi_hd_music_book_program/presentation/notifiers/music_book_notifier.dart';

class AddEditEntryScreen extends ConsumerStatefulWidget {
  final MusicBookEntry? entry;

  const AddEditEntryScreen({Key? key, this.entry}) : super(key: key);

  @override
  _AddEditEntryScreenState createState() => _AddEditEntryScreenState();
}

class _AddEditEntryScreenState extends ConsumerState<AddEditEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _artist;
  late String _album;
  late String _genre;
  late int _year;

  @override
  void initState() {
    super.initState();
    _title = widget.entry?.title ?? '';
    _artist = widget.entry?.artist ?? '';
    _album = widget.entry?.album ?? '';
    _genre = widget.entry?.genre ?? '';
    _year = widget.entry?.year ?? DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry == null ? 'Add Entry' : 'Edit Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _artist,
                decoration: const InputDecoration(labelText: 'Artist'),
                validator: (value) => value!.isEmpty ? 'Please enter an artist' : null,
                onSaved: (value) => _artist = value!,
              ),
              TextFormField(
                initialValue: _album,
                decoration: const InputDecoration(labelText: 'Album'),
                validator: (value) => value!.isEmpty ? 'Please enter an album' : null,
                onSaved: (value) => _album = value!,
              ),
              TextFormField(
                initialValue: _genre,
                decoration: const InputDecoration(labelText: 'Genre'),
                validator: (value) => value!.isEmpty ? 'Please enter a genre' : null,
                onSaved: (value) => _genre = value!,
              ),
              TextFormField(
                initialValue: _year.toString(),
                decoration: const InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter a year' : null,
                onSaved: (value) => _year = int.parse(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final notifier = ref.read(musicBookNotifierProvider.notifier);
      if (widget.entry == null) {
        final newEntry = MusicBookEntry(
          id: DateTime.now().toString(), // Not ideal, but fine for this example
          title: _title,
          artist: _artist,
          album: _album,
          genre: _genre,
          year: _year,
        );
        notifier.addMusicBookEntry(newEntry);
      } else {
        final updatedEntry = widget.entry!.copyWith(
          title: _title,
          artist: _artist,
          album: _album,
          genre: _genre,
          year: _year,
        );
        notifier.updateMusicBookEntry(updatedEntry);
      }
      Navigator.of(context).pop();
    }
  }
}
