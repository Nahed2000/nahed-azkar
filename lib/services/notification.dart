import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../storage/pref_controller.dart';
import '../data/azkar.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService with Helpers {
  NotificationService._();

  static final NotificationService _instance = NotificationService._();

  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = "liytmain_qalbi";
  static const String _channelName = "إشعارات";
  static const String _channelDescription = "إشعارات خاصة بتطبيق ليطمئن قلبي";

  Future<void> requestAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('appicon');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
  }

  void _onNotificationResponse(NotificationResponse response) {
    if (response.payload != null) {
      debugPrint('Notification payload: ${response.payload}');
    }
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
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
  }

  Future<void> sendNowNotification({
    required String title,
    required String body,
  }) async {
    await _notificationsPlugin.show(
      585,
      title,
      body,
      _notificationDetails(),
      payload: "بيانات إضافية",
    );
  }

  Future<void> showHourlyNotification() async {
    tz.initializeTimeZones();
    int randomIndex = Random().nextInt(DataOfAzkar.randomZikr.length);
    await _notificationsPlugin.periodicallyShow(
      0,
      "ليطمئن قلبي",
      DataOfAzkar.randomZikr[randomIndex][0],
      RepeatInterval.hourly,
      _notificationDetails(),
      payload: "معلومات إضافية",
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> showWeeklyNotification() async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledTime = _nextInstanceOfFridayAt(10);
    if (now.isAfter(scheduledTime)) {
      scheduledTime = scheduledTime.add(const Duration(days: 7));
    }
    await _notificationsPlugin.zonedSchedule(
      1,
      "ليطمئن قلبي",
      "لا تنسى قراءة سورة الكهف",
      scheduledTime,
      _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "لا تنسى قراءة سورة الكهف",
    );
  }

  tz.TZDateTime _nextInstanceOfFridayAt(int hour) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    int daysUntilFriday = (DateTime.friday - now.weekday) % 7;
    return tz.TZDateTime(
        tz.local, now.year, now.month, now.day + daysUntilFriday, hour);
  }

  Future<void> showDailyNotification({
    required int id,
    required int hour,
    required String title,
    required String body,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledTime =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour);
    if (now.isAfter(scheduledTime)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: "معلومات إضافية",
    );
  }

  Future<void> cancelNotification(int id) async =>
      await _notificationsPlugin.cancel(id);

  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<void> sendNotificationWithoutPrefController() async {
    tz.initializeTimeZones();
    await showWeeklyNotification();
    azkarMornings();
    azkarEvening();
    quranDaily();
    prayOfMohammed();
    showHourlyNotification();
  }

  Future<void> sendAllNotificationsBasedOnPreferences() async {
    if (PrefController().allNotificationItem) {
      if (PrefController().alkahefNotificationItem) {
        showWeeklyNotification();
      }
      if (PrefController().morningNotificationItem) {
        azkarMornings();
      }
      if (PrefController().eveningNotificationItem) {
        azkarEvening();
      }
      if (PrefController().quranNotificationItem) {
        quranDaily();
      }
      if (PrefController().prayOfMohammedNotification) {
        prayOfMohammed();
      }
      if (PrefController().hourlyNotificationItem) {}
    }
  }

  void azkarMornings() {
    showDailyNotification(
        id: 60,
        title: 'أذكار الصباح',
        body: 'لا تنسى قراءة أذكار الصباح',
        hour: 5);
    showDailyNotification(
        id: 61,
        title: 'أذكار الصباح',
        body: 'لا تنسى قراءة أذكار الصباح',
        hour: 7);
    showDailyNotification(
        id: 88,
        title: 'أذكار الصباح',
        body: 'لا تنسى قراءة أذكار الصباح',
        hour: 8);
  }

  void azkarEvening() {
    showDailyNotification(
        id: 62,
        title: 'أذكار المساء',
        body: 'لا تنسى قراءة أذكار المساء',
        hour: 14);
    showDailyNotification(
        id: 63,
        title: 'أذكار المساء',
        body: 'لا تنسى قراءة أذكار المساء',
        hour: 17);
    showDailyNotification(
        id: 77,
        title: 'أذكار المساء',
        body: 'لا تنسى قراءة أذكار المساء',
        hour: 20);
  }

  void prayOfMohammed() {
    NotificationService().showDailyNotification(
        id: 65,
        title: 'ليطمئن قلبي',
        body: 'اللهم صلِّ وسلم على أفضل الخلق سيدنا محمد',
        hour: 11);
    NotificationService().showDailyNotification(
        id: 66,
        title: 'ليطمئن قلبي',
        body: 'اللهم صلِّ وسلم على أفضل الخلق سيدنا محمد',
        hour: 15);
    NotificationService().showDailyNotification(
        id: 67,
        title: 'ليطمئن قلبي',
        body: 'اللهم صلِّ وسلم على أفضل الخلق سيدنا محمد',
        hour: 10);
    NotificationService().showDailyNotification(
        id: 68,
        title: 'ليطمئن قلبي',
        body: 'اللهم صلِّ  وسلم على أفضل الخلق سيدنا محمد',
        hour: 14);
    NotificationService().showDailyNotification(
        id: 69,
        title: 'ليطمئن قلبي',
        body: 'اللهم صلِّ وسلم على أفضل الخلق سيدنا محمد',
        hour: 16);
    NotificationService().showDailyNotification(
        id: 70,
        title: 'ليطمئن قلبي',
        body: 'اللهم صلِّ وسلم على أفضل الخلق سيدنا محمد',
        hour: 16);
    NotificationService().showDailyNotification(
        id: 71,
        title: 'ليطمئن قلبي',
        body: 'اللهم صلِّ وسلم على أفضل الخلق سيدنا محمد',
        hour: 16);
  }

  void quranDaily() {
    NotificationService().showDailyNotification(
        id: 48,
        title: "ليطمئن قلبي",
        body: 'لا تنسى قراءة وردك اليومي من القران الكريم',
        hour: 13);
    NotificationService().showDailyNotification(
        id: 49,
        title: "ليطمئن قلبي",
        body: 'لا تنسى قراءة وردك اليومي من القران الكريم',
        hour: 15);
    NotificationService().showDailyNotification(
        id: 55,
        title: "ليطمئن قلبي",
        body: 'لا تنسى قراءة وردك اليومي من القران الكريم',
        hour: 11);
    NotificationService().showDailyNotification(
        id: 56,
        title: "ليطمئن قلبي",
        body: 'لا تنسى قراءة وردك اليومي من القران الكريم',
        hour: 4);
  }
}
