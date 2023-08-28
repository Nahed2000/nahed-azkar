import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey {
  primaryColor,
  countZekr,
  changeAllNotificationItem,
  hourlyNotificationItem,
  alkahefNotificationItem,
  quranNotificationItem,
  prayOfMohammedNotificationItem,
  morningNotificationItem,
  eveningNotificationItem,
}

class SharedPrefController {
  static final SharedPrefController instance = SharedPrefController._();

  factory SharedPrefController() {
    return instance;
  }

  late SharedPreferences sharedPreferences;

  SharedPrefController._();

  Future<void> initPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> changePrimaryColor(int color) async {
    return await sharedPreferences.setInt(
        PrefKey.primaryColor.toString(), color);
  }

  int get primaryColor =>
      sharedPreferences.getInt(PrefKey.primaryColor.toString()) ?? 0xff643975;

  Future<bool> changeAllNotification(bool value) async {
    return await sharedPreferences.setBool(
      PrefKey.changeAllNotificationItem.toString(),
      value,
    );
  }

  bool get allNotificationItem =>
      sharedPreferences.getBool(PrefKey.changeAllNotificationItem.toString()) ??
      true;

  Future<bool> changeHourlyNotificationItem(bool value) async {
    return await sharedPreferences.setBool(
      PrefKey.hourlyNotificationItem.toString(),
      value,
    );
  }

  bool get hourlyNotificationItem =>
      sharedPreferences.getBool(PrefKey.hourlyNotificationItem.toString()) ??
      true;

  Future<bool> changeAkahefNotificationItem(bool value) async {
    return await sharedPreferences.setBool(
      PrefKey.alkahefNotificationItem.toString(),
      value,
    );
  }

  bool get alkahefNotificationItem =>
      sharedPreferences.getBool(PrefKey.alkahefNotificationItem.toString()) ??
      true;

  Future<bool> changeQuranNotificationItem(bool value) async {
    return await sharedPreferences.setBool(
      PrefKey.quranNotificationItem.toString(),
      value,
    );
  }

  bool get quranNotificationItem =>
      sharedPreferences.getBool(PrefKey.quranNotificationItem.toString()) ??
      true;

  Future<bool> changePrayOfMohammedNotification(bool value) async {
    return await sharedPreferences.setBool(
      PrefKey.prayOfMohammedNotificationItem.toString(),
      value,
    );
  }

  bool get prayOfMohammedNotification =>
      sharedPreferences
          .getBool(PrefKey.prayOfMohammedNotificationItem.toString()) ??
      true;

  Future<bool> changeMorningNotificationItem(bool value) async {
    return await sharedPreferences.setBool(
      PrefKey.morningNotificationItem.toString(),
      value,
    );
  }

  bool get morningNotificationItem =>
      sharedPreferences
          .getBool(PrefKey.morningNotificationItem.toString()) ??
      true;

  Future<bool> changeEveningNotificationItem(bool value) async {
    return await sharedPreferences.setBool(
      PrefKey.eveningNotificationItem.toString(),
      value,
    );
  }

  bool get eveningNotificationItem =>
      sharedPreferences
          .getBool(PrefKey.eveningNotificationItem.toString()) ??
      true;
}
