import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../data/azkar.dart';

import 'package:timezone/timezone.dart' as tz;

import '../pref/pref_controller.dart';

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

  int randomIndex = Random().nextInt(DataOfAzkar.randomZikr.length);

  static const String sendChannelId = "ليطمئن قلبي";
  static const String sendChannelName = "إشعارات";
  static const String channelDescription = " إشعارات خاصة بتطبيق ليطمئن قلبي";

  void sendNotificationToUser() async {
    if (SharedPrefController().hourlyNotificationItem == false) {
      return;
    }
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      sendChannelId,
      sendChannelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.max,
      color: Color(0xff643975),
    );
    DarwinNotificationDetails iosPlatformChannelSpecifics =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      sendChannelId,
      DataOfAzkar.randomZikr[randomIndex][0],
      platformChannelSpecifics,
      payload: "معلومات اضافية",
    );
  }

  void showSingleNotificationWeekly() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      sendChannelId,
      sendChannelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.max,
      color: Color(0xff643975),
    );
    DarwinNotificationDetails iosPlatformChannelSpecifics =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime nextFriday = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + (DateTime.friday - now.weekday),
      10,
      0,
    );

    // Calculate the next Friday if the current time is already past 10 AM
    if (now.isAfter(nextFriday)) {
      nextFriday = nextFriday.add(const Duration(days: 7));
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      101,
      "ليطمئن قلبي",
      "لا تنسى قراءة سورة الكهف",
      nextFriday,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: "لا تنسى قراءة سورة الكهف",
    );
  }

  void showDailyNotification({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Calculate the next day if the current time is already past 10 AM
    if (now.isAfter(scheduledTime)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    NotificationDetails platformChannelSpecifics = const NotificationDetails(
      android: AndroidNotificationDetails(
        "ليطمئن قلبي",
        "إشعارات",
        channelDescription: " إشعارات خاصة بتطبيق ليطمئن قلبي",
        importance: Importance.max,
        priority: Priority.max,
        color: Color(0xff643975),
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: "معلومات إضافية",
    );
  }

  void showSingleNotification() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      sendChannelId,
      sendChannelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.max,
      color: Color(0xff643975),
    );
    DarwinNotificationDetails iosPlatformChannelSpecifics =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      103,
      "ليطمئن قلبي",
      DataOfAzkar.randomZikr[randomIndex][0],
      RepeatInterval.hourly,
      platformChannelSpecifics,
      payload: "لا تنسى قراءة سورة الكهف",
    );
  }

  sendNotification() {
    if (SharedPrefController().allNotificationItem == false) {
      return;
    }
    showSingleNotification();
    if (SharedPrefController().alkahefNotificationItem) {
      showSingleNotificationWeekly();
    }
    if (SharedPrefController().morningNotificationItem) {
      NotificationService().showDailyNotification(
          id: 60,
          title: 'أذكار الصباح',
          body: 'لا تنسى قراءة أذكار الصباح',
          hour: 8,
          minute: 0);
      NotificationService().showDailyNotification(
        id: 61,
        title: 'أذكار الصباح',
        body: 'لا تنسى قراءة أذكار الصباح',
        hour: 9,
        minute: 20,
      );
    }

    if (SharedPrefController().eveningNotificationItem) {
      NotificationService().showDailyNotification(
        id: 62,
        title: 'أذكار المساء',
        body: 'لا تنسى قراءة أذكار المساء',
        hour: 17,
        minute: 30,
      );
      NotificationService().showDailyNotification(
        id: 63,
        title: 'أذكار المساء',
        body: 'لا تنسى قراءة أذكار المساء',
        hour: 21,
        minute: 30,
      );
    }

    if (SharedPrefController().quranNotificationItem) {
      NotificationService().showDailyNotification(
        id: 48,
        title: "الورد اليومي",
        body: 'لا تنسى قراءة وردك اليومي من القران الكريم',
        hour: 13,
        minute: 30,
      );
      NotificationService().showDailyNotification(
        id: 64,
        title: "الورد اليومي",
        body: 'لا تنسى قراءة وردك اليومي من القران الكريم',
        hour: 18,
        minute: 30,
      );
    }

    if (SharedPrefController().prayOfMohammedNotification) {
      NotificationService().showDailyNotification(
        id: 65,
        title: 'الصلاة على النبي',
        body: 'اللهم صلي وسلم على أفضل الخلق سيدنا محمد',
        hour: 11,
        minute: 30,
      );
      NotificationService().showDailyNotification(
        id: 66,
        title: 'الصلاة على النبي',
        body: 'اللهم صلي وسلم على أفضل الخلق سيدنا محمد',
        hour: 15,
        minute: 30,
      );
      NotificationService().showDailyNotification(
        id: 67,
        title: 'الصلاة على النبي',
        body: 'اللهم صلي وسلم على أفضل الخلق سيدنا محمد',
        hour: 20,
        minute: 30,
      );
    }
  }
}
