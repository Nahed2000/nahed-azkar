import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey {
  suraNumber,
  pixels,
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

class PrefController {
  static final PrefController instance = PrefController._();

  factory PrefController() {
    return instance;
  }

  late SharedPreferences sharedPreferences;

  PrefController._();

  Future<void> initPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveUserLocation(
      {required double latitude, required double longitude}) async {
    await sharedPreferences.setDouble(PrefKey.longitude.toString(), longitude);
    await sharedPreferences.setDouble(PrefKey.latitude.toString(), latitude);
  }

  Future<void> clear() async => await sharedPreferences.clear();

  Future<void> saveSura(
      {required int suraNumber, required double pixels}) async {
    await sharedPreferences.setInt(PrefKey.suraNumber.toString(), suraNumber);
    await sharedPreferences.setDouble(PrefKey.pixels.toString(), pixels);
  }

  double get pixels =>
      sharedPreferences.getDouble(PrefKey.suraNumber.toString()) ?? 0;

  int get suraNumber =>
      sharedPreferences.getInt(PrefKey.pixels.toString()) ?? 0;

  double? get longitude =>
      sharedPreferences.getDouble(PrefKey.longitude.toString());

  double? get latitude =>
      sharedPreferences.getDouble(PrefKey.latitude.toString());

  Future<bool> changePrimaryColor(int color) async =>
      await sharedPreferences.setInt(PrefKey.primaryColor.toString(), color);

  int get primaryColor =>
      sharedPreferences.getInt(PrefKey.primaryColor.toString()) ?? 0xff643975;

  Future<bool> changeAllNotification(bool value) async =>
      await sharedPreferences.setBool(
        PrefKey.changeAllNotificationItem.toString(),
        value,
      );

  bool get allNotificationItem =>
      sharedPreferences.getBool(PrefKey.changeAllNotificationItem.toString()) ??
      true;

  Future<bool> changeHourlyNotificationItem(bool value) async =>
      await sharedPreferences.setBool(
        PrefKey.hourlyNotificationItem.toString(),
        value,
      );

  bool get hourlyNotificationItem =>
      sharedPreferences.getBool(PrefKey.hourlyNotificationItem.toString()) ??
      true;

  Future<bool> changeAkahefNotificationItem(bool value) async =>
      await sharedPreferences.setBool(
          PrefKey.alkahefNotificationItem.toString(), value);

  bool get alkahefNotificationItem =>
      sharedPreferences.getBool(PrefKey.alkahefNotificationItem.toString()) ??
      true;

  Future<bool> changeQuranNotificationItem(bool value) async =>
      await sharedPreferences.setBool(
          PrefKey.quranNotificationItem.toString(), value);

  bool get quranNotificationItem =>
      sharedPreferences.getBool(PrefKey.quranNotificationItem.toString()) ??
      true;

  Future<bool> changePrayOfMohammedNotification(bool value) async =>
      await sharedPreferences.setBool(
          PrefKey.prayOfMohammedNotificationItem.toString(), value);

  bool get prayOfMohammedNotification =>
      sharedPreferences
          .getBool(PrefKey.prayOfMohammedNotificationItem.toString()) ??
      true;

  Future<bool> changeMorningNotificationItem(bool value) async =>
      await sharedPreferences.setBool(
          PrefKey.morningNotificationItem.toString(), value);

  bool get morningNotificationItem =>
      sharedPreferences.getBool(PrefKey.morningNotificationItem.toString()) ??
      true;

  Future<bool> changeEveningNotificationItem(bool value) async =>
      await sharedPreferences.setBool(
          PrefKey.eveningNotificationItem.toString(), value);

  bool get eveningNotificationItem =>
      sharedPreferences.getBool(PrefKey.eveningNotificationItem.toString()) ??
      true;
}
