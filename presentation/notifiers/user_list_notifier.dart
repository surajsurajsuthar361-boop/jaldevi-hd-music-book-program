import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/data/models/result.dart';
import 'package:jaldevi_hd_music_book_program/data/services/user_service.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';

final userListNotifierProvider = StateNotifierProvider<UserListNotifier, Result<List<User>>>((ref) {
  return UserListNotifier(ref.watch(userServiceProvider));
});

class UserListNotifier extends StateNotifier<Result<List<User>>> {
  final UserService _userService;

  UserListNotifier(this._userService) : super(const Result.initial()) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    state = const Result.loading();
    try {
      final users = await _userService.getUsers();
      state = Result.success(users);
    } catch (e) {
      state = Result.error('Could not fetch users: ${e.toString()}');
    }
  }
}
