import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/models/user_model.dart';
import '../services/firebase_service.dart';
import '../constants/app_constants.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  // Getters for user role
  bool get isCustomer => _currentUser?.isCustomer ?? false;
  bool get isRestaurant => _currentUser?.isRestaurant ?? false;
  bool get isRider => _currentUser?.isRider ?? false;
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  AuthProvider() {
    _initializeAuth();
  }

  void _initializeAuth() {
    FirebaseService.auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await _loadUserData(user.uid);
      } else {
        _currentUser = null;
        notifyListeners();
      }
    });
  }

  Future<void> _loadUserData(String uid) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final doc = await FirebaseService.getDocument('${AppConstants.usersCollection}/$uid');
      if (doc.exists) {
        _currentUser = UserModel.fromMap(doc.data()!);
      } else {
        _errorMessage = 'User data not found';
      }
    } catch (e) {
      _errorMessage = 'Failed to load user data: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final userCredential = await FirebaseService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _loadUserData(userCredential.user!.uid);
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = _getAuthErrorMessage(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
    String? address,
    Map<String, dynamic>? location,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final userCredential = await FirebaseService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final user = UserModel(
          id: userCredential.user!.uid,
          email: email,
          name: name,
          phone: phone,
          role: role,
          address: address,
          location: location,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await FirebaseService.setDocument(
          '${AppConstants.usersCollection}/${userCredential.user!.uid}',
          user.toMap(),
        );

        _currentUser = user;
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = _getAuthErrorMessage(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProfile({
    String? name,
    String? phone,
    String? address,
    Map<String, dynamic>? location,
    String? profileImageUrl,
  }) async {
    if (_currentUser == null) return false;

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final updatedUser = _currentUser!.copyWith(
        name: name ?? _currentUser!.name,
        phone: phone ?? _currentUser!.phone,
        address: address ?? _currentUser!.address,
        location: location ?? _currentUser!.location,
        profileImageUrl: profileImageUrl ?? _currentUser!.profileImageUrl,
        updatedAt: DateTime.now(),
      );

      await FirebaseService.updateDocument(
        '${AppConstants.usersCollection}/${_currentUser!.id}',
        updatedUser.toMap(),
      );

      _currentUser = updatedUser;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update profile: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (_currentUser == null) return false;

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final user = FirebaseService.currentUser;
      if (user == null) return false;

      // Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);
      return true;
    } catch (e) {
      _errorMessage = _getAuthErrorMessage(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await FirebaseService.signOut();
      _currentUser = null;
    } catch (e) {
      _errorMessage = 'Failed to sign out: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteAccount() async {
    if (_currentUser == null) return false;

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Delete user data from Firestore
      await FirebaseService.deleteDocument(
        '${AppConstants.usersCollection}/${_currentUser!.id}',
      );

      // Delete user account
      await FirebaseService.currentUser?.delete();
      
      _currentUser = null;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete account: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  String _getAuthErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found with this email address.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'An account already exists with this email address.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-disabled':
          return 'This account has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'operation-not-allowed':
          return 'This operation is not allowed.';
        default:
          return error.message ?? 'Authentication failed.';
      }
    }
    return 'An unexpected error occurred.';
  }
}
