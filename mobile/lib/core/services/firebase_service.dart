import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;
  static FirebaseMessaging get messaging => FirebaseMessaging.instance;
  static FirebaseDatabase get database => FirebaseDatabase.instance;

  static Future<void> initialize() async {
    await Firebase.initializeApp();
    
    // Initialize Firebase Auth
    await auth.authStateChanges().first;
    
    // Initialize Firestore
    firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    
    // Initialize FCM
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    
    // Initialize Realtime Database
    await database.setPersistenceEnabled(true);
  }

  // Auth Methods
  static Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static User? get currentUser => auth.currentUser;

  // Firestore Methods
  static Future<DocumentSnapshot> getDocument(String path) async {
    return await firestore.doc(path).get();
  }

  static Future<QuerySnapshot> getCollection(String path) async {
    return await firestore.collection(path).get();
  }

  static Future<QuerySnapshot> getCollectionWithQuery(
    String path,
    Query Function(Query query) queryBuilder,
  ) async {
    return await queryBuilder(firestore.collection(path)).get();
  }

  static Future<void> setDocument(String path, Map<String, dynamic> data) async {
    await firestore.doc(path).set(data);
  }

  static Future<void> updateDocument(String path, Map<String, dynamic> data) async {
    await firestore.doc(path).update(data);
  }

  static Future<void> deleteDocument(String path) async {
    await firestore.doc(path).delete();
  }

  static Stream<DocumentSnapshot> streamDocument(String path) {
    return firestore.doc(path).snapshots();
  }

  static Stream<QuerySnapshot> streamCollection(String path) {
    return firestore.collection(path).snapshots();
  }

  static Stream<QuerySnapshot> streamCollectionWithQuery(
    String path,
    Query Function(Query query) queryBuilder,
  ) {
    return queryBuilder(firestore.collection(path)).snapshots();
  }

  // Storage Methods
  static Future<String> uploadFile({
    required String path,
    required List<int> data,
    required String contentType,
  }) async {
    final ref = storage.ref().child(path);
    final uploadTask = ref.putData(
      data,
      SettableMetadata(contentType: contentType),
    );
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  static Future<void> deleteFile(String path) async {
    await storage.ref().child(path).delete();
  }

  // Realtime Database Methods
  static Future<void> setRealtimeData(String path, Map<String, dynamic> data) async {
    await database.ref(path).set(data);
  }

  static Future<void> updateRealtimeData(String path, Map<String, dynamic> data) async {
    await database.ref(path).update(data);
  }

  static Future<void> deleteRealtimeData(String path) async {
    await database.ref(path).remove();
  }

  static Stream<DatabaseEvent> streamRealtimeData(String path) {
    return database.ref(path).onValue;
  }

  // FCM Methods
  static Future<String?> getFCMToken() async {
    return await messaging.getToken();
  }

  static Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await messaging.unsubscribeFromTopic(topic);
  }

  // Batch Operations
  static WriteBatch batch() => firestore.batch();

  static Future<void> commitBatch(WriteBatch batch) async {
    await batch.commit();
  }

  // Transaction
  static Future<T> runTransaction<T>(
    Future<T> Function(Transaction transaction) updateFunction,
  ) async {
    return await firestore.runTransaction(updateFunction);
  }
}
