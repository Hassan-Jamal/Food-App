import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../services/firebase_service.dart';

class NotificationProvider with ChangeNotifier {
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _fcmToken;

  List<Map<String, dynamic>> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get fcmToken => _fcmToken;

  Future<void> initialize() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token
      _fcmToken = await FirebaseService.getFCMToken();

      // Configure FCM message handlers
      _configureFCMHandlers();

      // Listen to real-time notifications
      _listenToRealtimeNotifications();

    } catch (e) {
      _errorMessage = 'Failed to initialize notifications: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    final payload = response.payload;
    if (payload != null) {
      // Navigate to appropriate screen based on payload
      _handleNotificationNavigation(payload);
    }
  }

  void _handleNotificationNavigation(String payload) {
    // Parse payload and navigate to appropriate screen
    // This will be implemented based on the app's navigation structure
  }

  void _configureFCMHandlers() {
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    // Show local notification when app is in foreground
    _showLocalNotification(message);
  }

  void _handleNotificationTap(RemoteMessage message) {
    // Handle notification tap when app is in background
    _handleNotificationNavigation(message.data.toString());
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'food_delivery_channel',
      'Food Delivery Notifications',
      channelDescription: 'Notifications for food delivery app',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'Food Delivery',
      message.notification?.body ?? 'You have a new notification',
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }

  void _listenToRealtimeNotifications() {
    // Listen to real-time notifications from Firebase Realtime Database
    // This will be implemented based on user role and specific notification paths
  }

  Future<void> loadNotifications(String userId, String userRole) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Load notifications from Firebase Realtime Database
      final snapshot = await FirebaseService.database
          .ref('notifications/$userRole/$userId')
          .orderByChild('timestamp')
          .get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        _notifications = data.entries
            .map((entry) => Map<String, dynamic>.from(entry.value as Map))
            .toList()
          ..sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
      }
    } catch (e) {
      _errorMessage = 'Failed to load notifications: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      // Mark notification as read in Firebase
      await FirebaseService.updateRealtimeData(
        'notifications/$notificationId',
        {'isRead': true},
      );

      // Update local list
      final index = _notifications.indexWhere((n) => n['id'] == notificationId);
      if (index != -1) {
        _notifications[index]['isRead'] = true;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to mark notification as read: ${e.toString()}';
    }
  }

  Future<void> markAllNotificationsAsRead() async {
    try {
      for (final notification in _notifications) {
        if (!notification['isRead']) {
          await markNotificationAsRead(notification['id']);
        }
      }
    } catch (e) {
      _errorMessage = 'Failed to mark all notifications as read: ${e.toString()}';
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      // Delete notification from Firebase
      await FirebaseService.deleteRealtimeData('notifications/$notificationId');

      // Remove from local list
      _notifications.removeWhere((n) => n['id'] == notificationId);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete notification: ${e.toString()}';
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      for (final notification in _notifications) {
        await deleteNotification(notification['id']);
      }
    } catch (e) {
      _errorMessage = 'Failed to clear all notifications: ${e.toString()}';
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseService.subscribeToTopic(topic);
    } catch (e) {
      _errorMessage = 'Failed to subscribe to topic: ${e.toString()}';
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await FirebaseService.unsubscribeFromTopic(topic);
    } catch (e) {
      _errorMessage = 'Failed to unsubscribe from topic: ${e.toString()}';
    }
  }

  int get unreadCount {
    return _notifications.where((n) => !n['isRead']).length;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

// Top-level function for background message handling
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background message
  print('Handling a background message: ${message.messageId}');
}
