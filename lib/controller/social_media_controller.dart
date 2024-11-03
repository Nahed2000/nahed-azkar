import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/constant.dart';

class SettingsController {
  void openWhatsAppChat() {
    launchUrl(Uri.parse("whatsapp://send?phone=+970594582822"));
  }

  void openGmailChat() {
    const url = 'mailto:nahed6843@gmail.com';
    launchUrl(Uri.parse(url));
  }

  void openTelegramChat() async {
    String url = 'tg://t.me/Nahed2000';
    await launchUrl(Uri.parse(url));
  }

  void goToWebsite(String websiteUrl) async {
    launchUrl(Uri.parse(websiteUrl));
  }

  void openInstagramProfile() async {
    var url = 'https://www.instagram.com/nahedoukal/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  void showTextSettings(context, textMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.all(20.w),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.w),
              topLeft: Radius.circular(15.w),
            )),
        elevation: 4,
        content: Text(
          textMessage,
          style: TextStyle(color: MyConstant.myWhite, fontSize: 14.sp),
          textAlign: TextAlign.center,
        ),
        backgroundColor: MyConstant.primaryColor,
      ),
    );
  }
}
