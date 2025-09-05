import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../common/constants/collections.dart';

Future<void> seedSampleData(FirebaseFirestore db) async {
  final WriteBatch batch = db.batch();
  final List<Map<String, dynamic>> restaurants = <Map<String, dynamic>>[
    {
      'name': 'Pink Burger House',
      'category': 'Burgers',
      'description': 'Juicy burgers and fries',
    },
    {
      'name': 'Sushi Panda',
      'category': 'Japanese',
      'description': 'Fresh sushi & rolls',
    },
  ];

  for (final Map<String, dynamic> r in restaurants) {
    final DocumentReference<Map<String, dynamic>> doc = db.collection(Collections.restaurants).doc();
    batch.set(doc, r);
  }

  await batch.commit();
}

