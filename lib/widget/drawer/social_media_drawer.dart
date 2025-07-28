import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/social_media_controller.dart';
import '../../services/constant.dart';

class SocialMediaDrawer extends StatelessWidget {
  SocialMediaDrawer({super.key});

  final SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: MyConstant.kWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () => settingsController.openWhatsAppChat(),
                icon: Icon(MyConstant.whatsapp,
                    color: MyConstant.kPrimary, size: 30.w)),
            IconButton(
              onPressed: () => settingsController.openGmailChat(),
              icon: Icon(Icons.email_outlined,
                  color: MyConstant.kPrimary, size: 30.w),
            ),
            IconButton(
              onPressed: () => settingsController.openTelegramChat(),
              icon: Icon(Icons.telegram_outlined,
                  color: MyConstant.kPrimary, size: 33.w),
            ),
            IconButton(
              onPressed: () => settingsController.openInstagramProfile(),
              icon: Icon(MyConstant.instagram,
                  color: MyConstant.kPrimary, size: 30.w),
            ),
          ],
        ),
      ),
    );
  }
}
