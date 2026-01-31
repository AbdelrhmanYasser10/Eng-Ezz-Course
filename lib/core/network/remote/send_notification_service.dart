import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class SendNotificationService {
  // Admin token to access firebase dashboard
  Future<String> getAccessToken() async {
    final jsonString = await rootBundle.loadString(
      "assets/keys/ecommerce-1c098-74ff3c0afbe3.json",
    );

    final accountCredentials = auth.ServiceAccountCredentials.fromJson(
      jsonString,
    );
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client = await auth.clientViaServiceAccount(
      accountCredentials,
      scopes,
    );
    return client.credentials.accessToken.data;
  }

  Future<void> sendNotification({
    required String token,
    required String title,
    required String body,
    required Map<String, String> data,
  }) async {
    final String accessToken = await getAccessToken();
    final String fcmUrl =
        'https://fcm.googleapis.com/v1/projects/ecommerce-1c098/messages:send';
    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(<String, dynamic>{
        'message': {
          'token': token,
          'notification': {'title': title, 'body': body},
          'data': data, // Add custom data here
          'android': {
            'notification': {
              'click_action':
                  'FLUTTER_NOTIFICATION_CLICK', // Required for tapping to trigger response
              'channel_id': 'high_importance_channel',
            },
          },
          'apns': {
            'payload': {
              'aps': { 'content-available': 1},
            },
          },
        },
      }),
    );
    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }
}
