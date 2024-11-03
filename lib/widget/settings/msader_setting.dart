import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/social_media_controller.dart';
import '../../services/constant.dart';
import 'msader.dart';
import 'settings_item.dart';

class MasaderSetting extends StatelessWidget {
  MasaderSetting({super.key});

  final SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      title: 'مصادر',
      icon: Icons.grid_view_rounded,
      onPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: MyConstant.myWhite,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.h),
                side: BorderSide(color: MyConstant.primaryColor)),
            title: Text(
              "المصادر",
              textAlign: TextAlign.center,
              style: TextStyle(color: MyConstant.myBlack, fontSize: 22.sp),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MsaderItem(
                    onPress: () => settingsController
                        .goToWebsite('https://www.islamweb.net/ar/'),
                    title: "إسلام ويب"),
                MsaderItem(
                    onPress: () => settingsController.goToWebsite(
                        'https://ayatmnalquran.com/y/%D8%A2%D9%8A%D8%A7%D8%AA-%D9%82%D8%B1%D8%A2%D9%86%D9%8A%D8%A9-%D9%85%D8%B9%D8%A8%D8%B1%D8%A9'),
                    title: "آيات من القرآن"),
                MsaderItem(
                  onPress: () => settingsController
                      .goToWebsite('https://www.atheer-radio.com/home/ar'),
                  title: 'أثير راديو',
                ),
                MsaderItem(
                    onPress: () => settingsController
                        .goToWebsite('https://api-quran.cf/API/'),
                    title: 'Api Quran'),
                MsaderItem(
                    onPress: () => settingsController
                        .goToWebsite('http://api.quran-tafseer.com/en/docs/'),
                    title: 'Quran Tafseer'),
                MsaderItem(
                  onPress: () =>
                      settingsController.goToWebsite('https://mp3quran.net/ar'),
                  title: 'MP3Quran',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
