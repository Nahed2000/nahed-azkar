import 'package:shared_preferences/shared_preferences.dart';

enum PrefKey { primaryColor }

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
}
