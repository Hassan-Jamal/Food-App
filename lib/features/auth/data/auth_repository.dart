import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(fb_auth.FirebaseAuth.instance);
});

class AuthRepository {
  AuthRepository(this._auth);
  final fb_auth.FirebaseAuth _auth;

  Stream<fb_auth.User?> authStateChanges() => _auth.authStateChanges();

  Future<fb_auth.UserCredential> signInWithEmail(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<fb_auth.UserCredential> registerWithEmail(String email, String password) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() => _auth.signOut();

  Future<fb_auth.UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final fb_auth.OAuthCredential credential = fb_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return _auth.signInWithCredential(credential);
  }
}

