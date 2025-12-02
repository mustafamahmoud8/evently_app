import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}

class FCMServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await requestPermissions();
    await getToken();
    await handleForegroundMessages();
  }

  static Future<void> requestPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    log('User granted permission: ${settings.authorizationStatus}');
  }

  static Future<String?> getToken() async {
    try {
      String? token = await messaging.getToken(
          vapidKey:
              'BB5zk7v-aIOj1p5aPHpubTZXp3qHcU7NwTy6bxOt5MLl5MhpHLoxHuTBKJytCIzx3mzmqRL_UHTc5CW1qPvk8V8');
      log('FCM token: $token');
      return token;
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  static Future<void> handleForegroundMessages() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }
}
