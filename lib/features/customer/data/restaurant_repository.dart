import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../common/providers/firebase_providers.dart';
import '../../../common/constants/collections.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final FirebaseFirestore db = ref.read(firestoreProvider);
  return RestaurantRepository(db);
});

class RestaurantRepository {
  RestaurantRepository(this._db);
  final FirebaseFirestore _db;

  Stream<List<Map<String, dynamic>>> streamRestaurants() {
    return _db
        .collection(Collections.restaurants)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> s) => s.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> d) => d.data()..putIfAbsent('id', () => d.id)).toList());
  }

  Stream<List<Map<String, dynamic>>> streamMenuItemsByRestaurant(String restaurantId) {
    return _db
        .collection(Collections.menuItems)
        .where('restaurantId', isEqualTo: restaurantId)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> s) => s.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> d) => d.data()..putIfAbsent('id', () => d.id)).toList());
  }
}

