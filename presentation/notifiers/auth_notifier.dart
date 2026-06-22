import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/data/models/result.dart';
import 'package:jaldevi_hd_music_book_program/data/services/auth_service.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, Result<User?>>((ref) {
  return AuthNotifier(ref.watch(authServiceProvider));
});

class AuthNotifier extends StateNotifier<Result<User?>> {
  final AuthService _authService;
  late final StreamSubscription<User?> _authStateSubscription;

  AuthNotifier(this._authService) : super(const Result.initial()) {
    _authStateSubscription = _authService.authStateChanges.listen((user) {
      state = Result.success(user);
    });
  }

  Future<void> signUp(String email, String password, String name) async {
    state = const Result.loading();
    try {
      final user = await _authService.signUp(email, password);
      if (user != null) {
        await _authService.createUserProfile(user.uid, name, email);
        final userProfile = await _authService.getUserProfile(user.uid);
        state = Result.success(userProfile);
      } else {
        state = const Result.error('Sign up failed. Please try again.');
      }
    } catch (e) {
      state = Result.error(e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const Result.loading();
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        final userProfile = await _authService.getUserProfile(user.uid);
        state = Result.success(userProfile);
      } else {
        state = const Result.error('Sign in failed. Please check your credentials.');
      }
    } catch (e) {
      state = Result.error(e.toString());
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = const Result.success(null);
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }
}
