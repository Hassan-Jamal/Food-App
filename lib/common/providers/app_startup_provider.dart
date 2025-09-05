import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_providers.dart';

final appStartupProvider = FutureProvider<void>((ref) async {
  await ref.read(firebaseInitializationProvider.future);
});

