import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';

class Review {
  final String id;
  final User user;
  final String comment;
  final double rating;

  Review({
    required this.id,
    required this.user,
    required this.comment,
    required this.rating,
  });
}
