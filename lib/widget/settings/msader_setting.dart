import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/widget/drawer/item_drawer.dart';

import '../../controller/social_media_controller.dart';
import '../../services/constant.dart';
import 'msader.dart';

class MasaderSetting extends StatelessWidget {
  MasaderSetting({super.key});

  final SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    return ItemDrawer(
      title: 'مصادر',
      iconData: Icons.grid_view_rounded,
      onPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: MyConstant.kWhite,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.h),
                side: BorderSide(color: MyConstant.kPrimary)),
            title: Text(
              "المصادر",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'ggess',
                  color: MyConstant.kBlack,
                  fontSize: 22.sp),
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
                      .goToWebsite('https://www.un-web.com/tools/'),
                  title: 'مملكة الويب',
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
      subtitle: 'قم بزيارة المصادر ...',
    );
  }
}
