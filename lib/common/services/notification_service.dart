import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  Future<void> requestPermissions() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<String?> getToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  void listenForeground(void Function(RemoteMessage) onMessage) {
    FirebaseMessaging.onMessage.listen(onMessage);
  }
}

