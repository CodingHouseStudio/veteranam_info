import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    deferred as local_notifications;
import 'package:injectable/injectable.dart';
import 'package:veteranam/shared/constants/enum.dart';
import 'package:veteranam/shared/models/failure_model/failure_model.dart';

@Singleton(order: -2)
class LocalNotificationRepository {
  LocalNotificationRepository() {
    _initFunction = _initializeNotifications();
  }
  late dynamic notificationsPlugin;
  late Future<bool> _initFunction;
  final random = Random();

  Future<bool> _initializeNotifications() async {
    await local_notifications.loadLibrary();
    notificationsPlugin = local_notifications.FlutterLocalNotificationsPlugin();
    return valueFutureErrorHelper(
      () async {
        // Android initialization
        final initializationSettingsAndroid =
            local_notifications.AndroidInitializationSettings(
          '@drawable/ic_notification',
        );

        // iOS initialization
        final initializationSettingsIOS =
            local_notifications.DarwinInitializationSettings(
          notificationCategories: [
            local_notifications.DarwinNotificationCategory(
              'veteranam_category',
              options: {
                local_notifications
                    .DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
              },
            ),
          ],
        );

        final initializationSettings =
            local_notifications.InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

        // Initialize the plugin with the settings
        // ignore: avoid_dynamic_calls
        await notificationsPlugin.initialize(initializationSettings);
        return true;
      },
      failureValue: false,
      methodName: 'initializeNotifications',
      className: 'NotificationRepository',
    );
  }

  Future<bool> showAndroidFeregroundNotification(RemoteMessage message) async {
    if (PlatformEnum.getPlatform.isAndroid) {
      final result = await _initFunction;
      if (!result) {
        _initFunction = _initializeNotifications();
        final result = await _initFunction;
        if (!result) {
          return false;
        }
      }
      final androidPlatformChannelSpecifics =
          local_notifications.AndroidNotificationDetails(
        'firebase_foreground_channel', // channel id
        'Foreground Notifications', // channel name
        channelDescription: 'Channel for Firebase foreground notifications',
        importance: local_notifications.Importance.max,
        priority: local_notifications.Priority.high,
        ticker: 'ticker',
      );

      final platformChannelSpecifics = local_notifications.NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      // Extract title/body from Firebase RemoteMessage
      final title = message.notification?.title ?? '';
      final body = message.notification?.body ?? '';

      return valueFutureErrorHelper(
        () async {
          // ignore: avoid_dynamic_calls
          await notificationsPlugin.show(
            message.hashCode, // unique ID
            title,
            body,
            platformChannelSpecifics,
            payload: 'firebase_foreground_notification',
          );
          return true;
        },
        failureValue: false,
        methodName: 'showAndroidFeregroundNotification',
        className: 'NotificationRepository',
      );
    } else {
      return false;
    }
  }
}
