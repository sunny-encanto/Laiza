import 'dart:developer' as consol;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:laiza/core/app_export.dart';

import '../../core/utils/pref_utils.dart';
import '../../main.dart';

class NotificationService {
  static late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  static Future<void> initialize() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      await requestForPermissionInIOS();
    }
    try {
      await _flutterLocalNotificationsPlugin.initialize(
        _initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          _onDidReceiveLocalNotification(notificationResponse);
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );
      consol.log('/----Flutter Local Notification initialized-----/');
    } catch (e) {
      consol.log('flutterLocalNotificationsPlugin.initialize error', error: e);
    }
  }

  // Request iOS notification permissions
  static Future<void> requestForPermissionInIOS() async {
    final bool? result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    if (result == true) {
      print('iOS notification permissions granted.');
    } else {
      print('iOS notification permissions denied.');
    }
  }

// initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  static const AndroidInitializationSettings _initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/notification_icon');

  // iOS and macOS initialization using DarwinInitializationSettings
  static const DarwinInitializationSettings _initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: _onDidReceiveLocalNotificationIOS,
  );

  static const InitializationSettings _initializationSettings =
      InitializationSettings(
    android: _initializationSettingsAndroid,
    iOS: _initializationSettingsDarwin,
  );

// Define Android-specific notification details
  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    '0',
    'your channel name',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.max,
    channelShowBadge: true,
    colorized: true,
    enableVibration: true,
    playSound: true,
    ticker: 'ticker',
  );

// Define iOS-specific notification details (DarwinNotificationDetails)
  static const DarwinNotificationDetails _iosNotificationDetails =
      DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  static const NotificationDetails _notificationDetails = NotificationDetails(
      android: _androidNotificationDetails, iOS: _iosNotificationDetails);

// Android-specific callback for when a notification is received

  static void _onDidReceiveLocalNotification(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      List data = payload!.split(',');
      if (PrefUtils.getId().isNotEmpty) {
        if (data[1] == NotificationType.Chat.name) {
          navigatorKey.currentState?.pushNamed(
            AppRoutes.chatBoxScreen,
            arguments: '${data[0]}',
          );
        }
      }
    }
  }

// iOS-specific callback for when a notification is received
  static Future _onDidReceiveLocalNotificationIOS(
      int id, String? title, String? body, String? payload) async {
    print('Local Notification taped ios');
    if (payload != null) {
      debugPrint('notification payload: $payload');
      List data = payload.split(',');
      if (PrefUtils.getId().isNotEmpty) {
        if (data[1] == NotificationType.Chat.name) {
          navigatorKey.currentState?.pushNamed(
            AppRoutes.chatBoxScreen,
            arguments: '${data[0]}',
          );
        }
      }
    }
  }

  // Handle background notification tap
  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    print('notificationTapBackground');
  }

  static void showLocalNotification(RemoteMessage message) async {
    final int notificationId = DateTime.now().millisecondsSinceEpoch;
    final int newNotificationId = notificationId % 2147483647;
    final Map<String, dynamic> payloadData = message.data;
    final String id = payloadData['id'] ?? '';
    final String type = payloadData['type'] ?? '';
    try {
      _flutterLocalNotificationsPlugin.show(
          Platform.isIOS ? newNotificationId : 0,
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          _notificationDetails,
          payload: '$id,$type');
    } catch (e) {
      consol.log('Notification Error', error: e);
    }
  }
}

enum NotificationType {
  Chat,
}
