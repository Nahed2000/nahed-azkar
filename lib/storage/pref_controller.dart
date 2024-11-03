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
  longitude,
  latitude,
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

  Future<void> saveUserLocation(
      {required double latitude, required double longitude}) async {
    await sharedPreferences.setDouble(PrefKey.longitude.toString(), longitude);
    await sharedPreferences.setDouble(PrefKey.latitude.toString(), latitude);
  }

  Future<void> clear() async => await sharedPreferences.clear();

  double? get latitude =>
      sharedPreferences.getDouble(PrefKey.latitude.toString());

  double? get longitude =>
      sharedPreferences.getDouble(PrefKey.longitude.toString());

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

  Future<bool> changeQuranNotificationItem(bool value) async =>
      await sharedPreferences.setBool(
          PrefKey.quranNotificationItem.toString(), value);

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
      sharedPreferences.getBool(PrefKey.morningNotificationItem.toString()) ??
      true;

  Future<bool> changeEveningNotificationItem(bool value) async {
    return await sharedPreferences.setBool(
      PrefKey.eveningNotificationItem.toString(),
      value,
    );
  }

  bool get eveningNotificationItem =>
      sharedPreferences.getBool(PrefKey.eveningNotificationItem.toString()) ??
      true;
}
