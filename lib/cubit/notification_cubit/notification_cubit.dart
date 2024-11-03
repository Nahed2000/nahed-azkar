import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahed_azkar/cubit/notification_cubit/notification_state.dart';
import 'package:nahed_azkar/services/notification.dart';

import '../../storage/pref_controller.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());

  // controller of all notification
  bool changeAllNotificationItem = SharedPrefController().allNotificationItem;

  bool hourlyNotificationItem = SharedPrefController().hourlyNotificationItem;

  bool alkahefNotificationItem = SharedPrefController().alkahefNotificationItem;

  bool quranNotificationItem = SharedPrefController().quranNotificationItem;

  bool prayOfMohammedNotificationItem =
      SharedPrefController().prayOfMohammedNotification;

  bool morningNotificationItem = SharedPrefController().morningNotificationItem;

  bool eveningNotificationItem = SharedPrefController().eveningNotificationItem;

  void changeAllNotification(bool value) async {
    await SharedPrefController().changeAllNotification(value);
    await SharedPrefController().changeHourlyNotificationItem(value);
    await SharedPrefController().changeAkahefNotificationItem(value);
    await SharedPrefController().changeQuranNotificationItem(value);
    await SharedPrefController().changePrayOfMohammedNotification(value);
    await SharedPrefController().changeMorningNotificationItem(value);
    await SharedPrefController().changeEveningNotificationItem(value);
    changeAllNotificationItem = value;
    hourlyNotificationItem = value;
    alkahefNotificationItem = value;
    quranNotificationItem = value;
    prayOfMohammedNotificationItem = value;
    morningNotificationItem = value;
    eveningNotificationItem = value;
    emit(ChangeAllNotificationState());
  }

  void hourlyNotification(bool value) {
    SharedPrefController().changeHourlyNotificationItem(value);
    NotificationService().sendNotificationsBasedOnPreferences();
    emit(HourlyNotificationState());
  }

  void alkahefNotification(bool value) {
    SharedPrefController().changeAkahefNotificationItem(value);
    NotificationService().sendNotificationsBasedOnPreferences();
    alkahefNotificationItem = value;
    emit(AlkahefNotificationState());
  }

  void quranNotification(bool value) {
    SharedPrefController().changeQuranNotificationItem(value);
    NotificationService().sendNotificationsBasedOnPreferences();
    quranNotificationItem = value;
    emit(QuranNotificationState());
  }

  void prayOfMohammedNotification(bool value) {
    SharedPrefController().changePrayOfMohammedNotification(value);
    NotificationService().sendNotificationsBasedOnPreferences();
    prayOfMohammedNotificationItem = value;
    emit(PrayOfMohammedNotificationState());
  }

  void morningNotification(bool value) {
    SharedPrefController().changeMorningNotificationItem(value);
    NotificationService().sendNotificationsBasedOnPreferences();
    morningNotificationItem = value;
    emit(MorningNotificationState());
  }

  void eveningNotification(bool value) {
    SharedPrefController().changeEveningNotificationItem(value);
    NotificationService().sendNotificationsBasedOnPreferences();
    eveningNotificationItem = value;

    emit(EveningNotificationState());
  }
}
