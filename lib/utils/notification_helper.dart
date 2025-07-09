import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:revalesuva/utils/app_colors.dart';

void notificationTapBackground(NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (payload != null) {
    debugPrint("Notification tapped in background: $payload");

    if (payload.toLowerCase().contains("reminder") || payload.toLowerCase().contains("client")) {
      // Handle navigation based on payload
    }
  }
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  try {
    debugPrint("Background message received: ${message.data["event"]}");
  } catch (e) {
    debugPrint(e.toString());
    rethrow;
  }
}

class HelperNotification {
  static Future<String> getFcmToken() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken().then((value) => value);
      debugPrint("fcm Token $fcmToken");
      return fcmToken ?? "";
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    enableVibration: true,
  );

  static const InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/launcher_icon'),
    iOS: DarwinInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestCriticalPermission: true,
    ),
  );

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveLocalNotification(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      debugPrint("Local notification received: $payload");
    }
  }

  static Future<void> initialize() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveLocalNotification,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        await showNotification(message);
      }
      if (message.data["details"] != null) {
        var data = jsonDecode(message.data["details"]);
        // Handle data
      }
    });

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        // Handle message opened from background
      } catch (e) {
        rethrow;
      }
    });
  }

  static Future<void> showNotification(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    if (Platform.isAndroid) {
      bool? notificationsEnabled = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled();

      if (notificationsEnabled == true && message.notification != null) {
        await flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification?.title,
          message.notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: AppColors.surfaceGreen,
              category: AndroidNotificationCategory.system,
              autoCancel: true,
              colorized: true,
              channelShowBadge: true,
              enableLights: true,
              chronometerCountDown: true,
              enableVibration: true,
              importance: Importance.max,
              icon: "@mipmap/launcher_icon",
              priority: Priority.high,
              visibility: NotificationVisibility.public,
              playSound: true,
              sound: const RawResourceAndroidNotificationSound("fcm_sound")
            ),
          ),
          payload: message.notification?.title.toString(),
        );
      }
    }
  }
}