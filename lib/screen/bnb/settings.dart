import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/controller/social_media_controller.dart';
import 'package:nahed_azkar/screen/home/my_azkar/azkary.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:share_plus/share_plus.dart';

import '../../cubit/home_cubit/home_state.dart';
import '../../services/constant.dart';
import '../../cubit/home_cubit/home_cubit.dart';
import '../../widget/settings/msader_setting.dart';
import '../../widget/settings/settings_item.dart';

class BNBarSettings extends StatelessWidget with Helpers {
  BNBarSettings({Key? key}) : super(key: key);

  final SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          physics: const ClampingScrollPhysics(),
          children: [
            const SettingsItem(
                title: 'الإشعارات',
                icon: Icons.notifications_active_outlined,
                routeScreen: '/notification_screen'),
            const SettingsItem(
                title: 'الايات المحفوظة',
                icon: FlutterIslamicIcons.quran2,
                routeScreen: '/aya_saved_screen'),
            const SettingsItem(
                title: 'التوقيت الهجري',
                icon: FlutterIslamicIcons.calendar,
                routeScreen: '/hijri_screen'),
            MasaderSetting(),
            SettingsItem(
                title: 'أذكاري الخاصة',
                icon: Icons.event_note_sharp,
                onPress: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Azkary(),
                    ))),
            SettingsItem(
                title: 'تغيير اللون',
                icon: Icons.color_lens_outlined,
                onPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => changeColorApp(cubit),
                  );
                }),
            SettingsItem(
                title: 'اللون الإفتراضي',
                icon: Icons.colorize,
                onPress: () {
                  cubit.changeAppColor(0xff643975);
                  showSnackBar(context, message: 'تم إستعادة اللون الإفتراضي');
                }),
            SettingsItem(
                title: 'تقييم التطبيق',
                icon: Icons.star_border,
                onPress: () => settingsController.goToWebsite(
                      'https://play.google.com/store/apps/details?id=com.ecokids.nahed_azkar&hl=en-US',
                    )),
            SettingsItem(
              title: 'مشاركة التطبيق',
              icon: Icons.share_outlined,
              onPress: () {
                Uri uri = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.ecokids.nahed_azkar&hl=en-US');
                Share.shareUri(uri);
              },
            ),
            SettingsItem(
                title: 'إغلاق التطبيق',
                icon: Icons.close,
                onPress: () => exit(0)),
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
            style: TextStyle(fontFamily: 'ggess', color: MyConstant.kPrimary),
          );
        },
      ),
      backgroundColor: MyConstant.kWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.h),
        side: BorderSide(color: MyConstant.kPrimary, width: 1),
      ),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: MyConstant.kPrimary,
          onColorChanged: (value) {
            cubit.changeAppColor(value.value);
          },
        ),
      ),
    );
  }
}
