import 'package:flutter/material.dart';
import 'package:nahed_azkar/storage/pref_controller.dart';

class MyConstant {
  static Color kWhite = Colors.white;
  static Color kBlack = Colors.black;
  static Color kGrey = Colors.grey.shade600;
  static Color kPrimary = Color(SharedPrefController().primaryColor);

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData cogOutline =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData instagram =
      IconData(0xf16d, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData whatsapp =
      IconData(0xf232, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
