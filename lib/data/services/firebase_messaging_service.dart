import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/services/notification_service.dart';

import '../../core/app_export.dart';
import '../../main.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Handle the case where the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (Platform.isAndroid) {
        NotificationService.showLocalNotification(message);
      }
    });

    // Handle the case where the app is in the background and resumed by tapping the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigatorKey.currentState
          ?.pushNamed(AppRoutes.chatBoxScreen, arguments: message.data['id']);
    });
    log('/----FirebaseMessagingService initialized-----/');
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}

  @pragma("vm:entry-point")
  static Future<void> onBackgroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Handle the case where the app is opened from a terminated state
  static Future<void> handleInitialMessage() async {
    await _firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        // Ensure navigation is triggered after initialization
        WidgetsBinding.instance.addPostFrameCallback((_) {
          navigatorKey.currentState?.pushReplacementNamed(
              AppRoutes.chatBoxScreen,
              arguments: message.data['id']);
        });
      }
    });
  }

  static const String projectNumber = '825576746102';
  static const String fcmEndpoint =
      'https://fcm.googleapis.com/v1/projects/$projectNumber/messages:send';
  static const String serviceAccountPath =
      'assets/json/laizanew-33d585212b5e.json';

  //Send Notification Method
  static Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    required String id,
    required String type,
  }) async {
    var dio = Dio();
    try {
      // Get OAuth 2.0 token
      final accessToken = await _getAccessToken();

      // Construct the notification payload
      var data = {
        "message": {
          "token": token,
          "notification": {
            "title": title,
            "body": body,
          },
          "data": {
            "id": PrefUtils.getId(),
            "type": type,
          }
        }
      };

      // Send the request to FCM V1 API
      var response = await dio.post(
        fcmEndpoint,
        data: jsonEncode(data),
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $accessToken',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('Notification sent successfully.');
      } else {
        debugPrint(
            'Notification sending failed with code: ${response.statusCode}.');
      }
    } catch (e) {
      if (e is DioException) {
        debugPrint(
            'Error: ${e.response?.data}'); // Log detailed error information
      } else {
        debugPrint('Error sending notification: $e');
      }
    }
  }

  // Helper function to get an OAuth 2.0 access token using service account
  static Future<String> _getAccessToken() async {
    // Load the JSON file from assets
    final jsonString =
        await rootBundle.loadString('assets/json/laizanew-33d585212b5e.json');
    final accountCredentials =
        ServiceAccountCredentials.fromJson(jsonDecode(jsonString));

    // Define the scopes required for FCM
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    // Get the access token
    final authClient =
        await clientViaServiceAccount(accountCredentials, scopes);
    return authClient.credentials.accessToken.data;
  }

  //get device token
  static Future<String?> generateToken() async {
    var notifyToken = await FirebaseMessaging.instance.isSupported()
        ? await FirebaseMessaging.instance.getToken()
        : "notifyToken";
    debugPrint('FCMTOKEN:::$notifyToken');
    return notifyToken;
  }
}
