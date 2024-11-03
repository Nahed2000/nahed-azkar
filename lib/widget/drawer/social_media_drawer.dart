import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/social_media_controller.dart';
import '../../services/constant.dart';

class SocialMediaDrawer extends StatelessWidget {
  SocialMediaDrawer({super.key});

  final SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () => settingsController.openWhatsAppChat(),
            icon: Icon(MyConstant.whatsapp,
                color: MyConstant.primaryColor, size: 35.w)),
        IconButton(
          onPressed: () => settingsController.openGmailChat(),
          icon: Icon(Icons.email_outlined,
              color: MyConstant.primaryColor, size: 35.w),
        ),
        IconButton(
          onPressed: () => settingsController.openTelegramChat(),
          icon: Icon(Icons.telegram_outlined,
              color: MyConstant.primaryColor, size: 38.w),
        ),
        IconButton(
          onPressed: () => settingsController.openInstagramProfile(),
          icon: Icon(MyConstant.instagram,
              color: MyConstant.primaryColor, size: 35.w),
        ),
      ],
    );
  }
}
