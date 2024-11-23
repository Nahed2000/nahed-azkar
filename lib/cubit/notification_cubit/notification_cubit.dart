import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahed_azkar/cubit/notification_cubit/notification_state.dart';
import 'package:nahed_azkar/services/notification.dart';

import '../../storage/pref_controller.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());

  void changeAllNotification(bool value) async {
    await SharedPrefController().changeAllNotification(value);
    await SharedPrefController().changeHourlyNotificationItem(value);
    await SharedPrefController().changeAkahefNotificationItem(value);
    await SharedPrefController().changeQuranNotificationItem(value);
    await SharedPrefController().changePrayOfMohammedNotification(value);
    await SharedPrefController().changeMorningNotificationItem(value);
    await SharedPrefController().changeEveningNotificationItem(value);
    value
        ? NotificationService().sendAllNotificationsBasedOnPreferences()
        : NotificationService().cancelAllNotifications();
    emit(ChangeAllNotificationState());
  }

  void hourlyNotification(bool value) {
    SharedPrefController().changeHourlyNotificationItem(value);
    value
        ? NotificationService().showHourlyNotification()
        : NotificationService().cancelNotification(0);
    emit(HourlyNotificationState());
  }

  void alkahefNotification(bool value) {
    SharedPrefController().changeAkahefNotificationItem(value);
    value
        ? NotificationService().showWeeklyNotification()
        : NotificationService().cancelNotification(1);
    emit(AlkahefNotificationState());
  }

  void quranNotification(bool value) {
    SharedPrefController().changeQuranNotificationItem(value);
    if (value) {
      NotificationService().quranDaily();
    } else {
      NotificationService().cancelNotification(48);
      NotificationService().cancelNotification(49);
    }
    emit(QuranNotificationState());
  }

  void prayOfMohammedNotification(bool value) {
    SharedPrefController().changePrayOfMohammedNotification(value);

    if (value) {
      NotificationService().prayOfMohammed();
    } else {
      NotificationService().cancelNotification(65);
      NotificationService().cancelNotification(66);
      NotificationService().cancelNotification(67);
      NotificationService().cancelNotification(68);
      NotificationService().cancelNotification(69);
    }
    emit(PrayOfMohammedNotificationState());
  }

  void morningNotification(bool value) {
    SharedPrefController().changeMorningNotificationItem(value);
    if (value) {
      NotificationService().azkarMornings();
    } else {
      NotificationService().cancelNotification(60);
      NotificationService().cancelNotification(61);
    }
    emit(MorningNotificationState());
  }

  void eveningNotification(bool value) {
    SharedPrefController().changeEveningNotificationItem(value);
    if (value) {
      NotificationService().quranDaily();
    } else {
      NotificationService().cancelNotification(62);
      NotificationService().cancelNotification(63);
    }
    emit(EveningNotificationState());
  }
}
