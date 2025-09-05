import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../data/auth_repository.dart';

final authStateProvider = StreamProvider<fb_auth.User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(ref.read);
});

class AuthController {
  AuthController(this._read);
  final Reader _read;

  Future<void> signInEmail({required String email, required String password}) async {
    await _read(authRepositoryProvider).signInWithEmail(email, password);
  }

  Future<void> registerEmail({required String email, required String password}) async {
    await _read(authRepositoryProvider).registerWithEmail(email, password);
  }

  Future<void> signInGoogle() async {
    await _read(authRepositoryProvider).signInWithGoogle();
  }

  Future<void> signOut() async {
    await _read(authRepositoryProvider).signOut();
  }
}

