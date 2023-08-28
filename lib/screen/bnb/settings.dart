import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/screen/app/my_azkar/azkary.dart';

import '../../services/constant.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../widget/app/settings_item.dart';
import '../app/quran/sura.dart';

class BNBarSettings extends StatelessWidget {
  const BNBarSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          shrinkWrap: true,
          children: [
            SettingsItem(
              title: cubit.themeMode == ThemeMode.light
                  ? 'الوضع الليلي'
                  : "الوضع الفاتح",
              icon: cubit.themeMode == ThemeMode.light
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              onPress: () {
                cubit.changeTheme();
              },
            ),
            SettingsItem(
              title: 'الإشعارات',
              icon: Icons.notifications_active_outlined,
              onPress: () {
                Navigator.pushNamed(context, '/notification_screen');
              },
            ),
            SettingsItem(
              title: 'التوقيت الهجري',
              icon: FlutterIslamicIcons.calendar,
              onPress: () {
                Navigator.pushNamed(context, '/hijri_screen');
              },
            ),
            SettingsItem(
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
                      style:
                          TextStyle(color: MyConstant.myBlack, fontSize: 22.sp),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () => BlocProvider.of<HomeCubit>(context)
                              .goToWebsite('https://www.islamweb.net/ar/'),
                          child: Text(
                            "إسلام ويب",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.blue, fontSize: 18.sp),
                          ),
                        ),
                        TextButton(
                          onPressed: () => BlocProvider.of<HomeCubit>(context)
                              .goToWebsite(
                                  'https://ayatmnalquran.com/y/%D8%A2%D9%8A%D8%A7%D8%AA-%D9%82%D8%B1%D8%A2%D9%86%D9%8A%D8%A9-%D9%85%D8%B9%D8%A8%D8%B1%D8%A9'),
                          child: Text(
                            "آيات من القرآن",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.blue, fontSize: 18.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SettingsItem(
              title: 'أذكاري الخاصة',
              icon: Icons.event_note_sharp,
              onPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Azkary(),
                    ));
              },
            ),
            SettingsItem(
              title: 'تغيير اللون',
              icon: Icons.color_lens_outlined,
              onPress: () {
                showDialog(
                  context: context,
                  builder: (context) => changeColorApp(cubit),
                );
              },
            ),
            SettingsItem(
              title: 'اللون الإفتراضي',
              icon: Icons.colorize,
              onPress: () {
                cubit.changeAppColor(0xff643975);
              },
            ),
            Divider(color: MyConstant.primaryColor),
            Column(
              children: [
                Text(
                  'سنن قرآنية',
                  style: TextStyle(
                    color: MyConstant.primaryColor,
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SettingsItem(
                  title: 'سورة الكهف',
                  icon: Icons.menu_book_outlined,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SuraQuran(currentIndex: 18),
                        ));
                  },
                ),
                SettingsItem(
                  title: 'سورة الملك',
                  icon: Icons.local_library_outlined,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SuraQuran(currentIndex: 67),
                      ),
                    );
                  },
                ),
                SettingsItem(
                  title: 'سورة البقرة',
                  icon: Icons.book,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SuraQuran(currentIndex: 2),
                        ));
                  },
                ),
              ],
            ),
            Divider(color: MyConstant.primaryColor),
            Text(
              'للتواصل',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyConstant.primaryColor,
                fontSize: 16.h,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<HomeCubit>(context)
                          .openWhatsAppChat('+970594582822');
                    },
                    icon: Icon(
                      MyConstant.whatsapp,
                      color: MyConstant.primaryColor,
                      size: 34.w,
                    )),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<HomeCubit>(context)
                        .openGmailChat('nahed6843@gmail.com');
                  },
                  icon: Icon(
                    Icons.email_outlined,
                    color: MyConstant.primaryColor,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<HomeCubit>(context)
                        .openTelegramChat('Nahed2000');
                  },
                  icon: Icon(
                    Icons.telegram_outlined,
                    color: MyConstant.primaryColor,
                    size: 35,
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  AlertDialog changeColorApp(HomeCubit cubit) {
    return AlertDialog(
      title: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Text(
            'تغير لون التطبيق',
            textAlign: TextAlign.center,
            style: TextStyle(color: MyConstant.primaryColor),
          );
        },
      ),
      backgroundColor: MyConstant.myWhite,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.h),
          side: BorderSide(color: MyConstant.primaryColor, width: 1)),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: MyConstant.primaryColor,
          onColorChanged: (value) {
            cubit.changeAppColor(value.value);
          },
        ),
      ),
    );
  }
}
