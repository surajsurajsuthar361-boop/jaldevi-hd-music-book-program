import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserById(String id);
  Future<void> updateUser(User user);
}
