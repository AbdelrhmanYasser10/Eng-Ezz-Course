import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class MessagingConfig {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  static String? _fcmToken;
  static Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel androidChannel =
        AndroidNotificationChannel(
          "high_importance_channel",
          "High Importance Notifications",
          description: "This is channel used for foreground notifications",
          sound: RawResourceAndroidNotificationSound("custom_sound"),
          importance: Importance.max,
        );

    await _flutterLocalNotificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }


  static Future<void> config()async{
    await createNotificationChannel();

    final notificationSettings = await FirebaseMessaging.instance.requestPermission();
    if(notificationSettings.authorizationStatus == AuthorizationStatus.authorized || notificationSettings.authorizationStatus == AuthorizationStatus.provisional){
      if(Platform.isIOS){
        await FirebaseMessaging.instance.getAPNSToken();
      }
      _fcmToken = await FirebaseMessaging.instance.getToken();
      log("my token is $_fcmToken");

      const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
      const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();
      const InitializationSettings notificationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS:  initializationSettingsIOS,
      );

      await _flutterLocalNotificationPlugin.initialize(settings: notificationSettings,onDidReceiveNotificationResponse: (details) {
        log("notification Details ${details.payload.toString()}");
      },);
      FirebaseMessaging.onMessage.listen((event)async{
        RemoteNotification? notification = event.notification;

        var body = notification?.body;
        await _flutterLocalNotificationPlugin.show(
          id: notification.hashCode,
          title: notification?.title,
          body: body,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              "high_importance_channel"
              ,
              "High Importance Notifications",
              channelDescription: "This channel used for important notifications",
                icon: "@mipmap/ic_launcher",
                importance: Importance.max,
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),

        );

      });

      FirebaseMessaging.instance.getInitialMessage().then(
        (value) {
          if(value!=null){}
        },
      );

      FirebaseMessaging.onMessageOpenedApp.listen((message){});
    }


  }

  static String? getFCMToken()=> _fcmToken;

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagningBackgroundHandler(RemoteMessage message) async{
    log("background : ${message.messageId}");
  }
}
