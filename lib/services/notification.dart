import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../data/azkar.dart';

class NotificationService {
  NotificationService._();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService =
      NotificationService._();

  //  (عندما يكون التطبيق مفتوح) يمكنك تنفيذ التنقل إلى الاشعار عند استلامه
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) async {
    debugPrint(
        'Received background notification: ${notificationResponse.payload}');
    // هنا يمكنك تنفيذ السلوك المخصص المرتبط بإشعار الخلفية
    // مثلاً: تحديث بيانات التطبيق
    // أو تنفيذ عملية معينة دون فتح التطبيق
  }

  // إعداد الإشعارات المحلية
  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');
    const DarwinInitializationSettings initializationSettingsIos =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIos);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static const String sendChannelId = "ليطمئن قلبي";
  static const String sendChannelName = "إشعارات";
  static const String channelDescription = " إشعارات خاصة بتطبيق ليطمئن قلبي";

  void sendNotificationToUser() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      sendChannelId,
      sendChannelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.max,
      color: Color(0xff643975),
    );
    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, sendChannelId,
        DataOfAzkar.randomZikr[randomIndex][0], platformChannelSpecifics,
        payload: "معلومات اضافية");
  }

  int randomIndex = Random().nextInt(DataOfAzkar.randomZikr.length);
  static const String seChannelId = "ليطمئن قلبي";
  static const String sChannelName = "إشعارات";
  static const String sChannelDescription = " إشعارات خاصة بتطبيق ليطمئن قلبي";

/*
d sNotificationTime() async {
  // Get the current date and time in the local time zone.

  // Create a TZDateTime object for Friday at 10:00 AM.
  final scheduledDate = tz.TZDateTime(now.year, now.month, now.day + 1, 10, 0);

  // Schedule the function to be called on the scheduled date.
  await flutterLocalNotificationsPlugin.zonedSchedule(0, seChannelId,
      "سبح اسم ربك الاعلى", scheduledDate, platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      payload: "تسسسسسسسسسستتتتتتت");
}
 */
// void alKahafNotification() async {
//   final now = tz.TZDateTime.now(tz.local);
//   final scheduledDate = now.add(Duration(hours: 12, minutes: 4));
//
//   print("Now: $now");
//   print("Scheduled Date: $scheduledDate");
//
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     seChannelId,
//     sChannelName,
//     channelDescription: sChannelDescription,
//     importance: Importance.max,
//     priority: Priority.max,
//     color: Color(0xff643975),
//   );
//   const DarwinNotificationDetails iosPlatformChannelSpecifics =
//       DarwinNotificationDetails(
//     presentAlert: true,
//     presentBadge: true,
//     presentSound: true,
//   );
//   const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iosPlatformChannelSpecifics);
//   print('we are herer');
//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     seChannelId,
//     "لا تنسى قراءة سورة الكهف",
//     scheduledDate,
//     platformChannelSpecifics,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//     payload: "لا تنسى قراءة سورة الكهف",
//   );
// }
}