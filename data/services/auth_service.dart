import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaldevi_hd_music_book_program/domain/entities/user.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  Future<firebase_auth.User?> signUp(String email, String password) async {
    final firebase_auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  // Sign in with email and password
  Future<firebase_auth.User?> signIn(String email, String password) async {
    final firebase_auth.UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  // Create a user profile in Firestore
  Future<void> createUserProfile(String uid, String name, String email) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'role': 'user', // Default role
    });
  }

  // Get user profile from Firestore
  Future<User> getUserProfile(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      return User.fromFirestore(snapshot);
    } else {
      throw Exception('User profile not found.');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get the current user
  firebase_auth.User? getCurrentUser() {
    return _auth.currentUser;
  }

 Stream<User?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return null;
      } else {
        return await getUserProfile(firebaseUser.uid);
      }
    });
  }
}
