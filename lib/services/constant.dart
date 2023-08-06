import 'package:flutter/material.dart';
import 'package:nahed_azkar/pref/pref_controller.dart';

class MyConstant {
  static Color myWhite = Colors.white;
  static Color myBlack = Colors.black;
  static Color myGrey = Colors.grey.shade600;
  static Color primaryColor = Color(SharedPrefController().primaryColor);

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData cogOutline =
      IconData(0xe84c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData whatsapp =
      IconData(0xf232, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

// services