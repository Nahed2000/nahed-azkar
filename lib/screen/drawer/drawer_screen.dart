import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:nahed_azkar/widget/drawer/custom_header_drawer.dart';
import 'package:nahed_azkar/widget/drawer/item_drawer.dart';
import 'package:nahed_azkar/widget/settings/msader_setting.dart';
import '../../cubit/home_cubit/home_cubit.dart';
import '../../cubit/home_cubit/home_state.dart';
import '../../data/azkar.dart';
import '../home/al_azkar/azkar_list.dart';
import '../home/my_azkar/azkary.dart';
import '../home/pray_of_mohammed.dart';
import '../settings/aya_saved_screen.dart';

class DrawerScreen extends StatelessWidget with Helpers {
  DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Drawer(
          elevation: 4,
          backgroundColor: MyConstant.kWhite,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(70.w),
                  bottomEnd: Radius.circular(70.w))),
          clipBehavior: Clip.antiAlias,
          surfaceTintColor: MyConstant.kPrimary,
          child: ListView(
            children: [
              const CustomHeaderDrawer(),
              SwitchListTile.adaptive(
                  activeColor: MyConstant.kPrimary,
                  value: cubit.isDarkMode,
                  onChanged: (value) {
                    cubit.changeTheme(value);
                    showSnackBar(context, message: 'تم تغيير الوضع');
                  },
                  title: Text('الوضع الليلي',
                      style: TextStyle(
                          fontFamily: 'ggess', color: MyConstant.kBlack))),
              Divider(color: MyConstant.kPrimary),
              MasaderSetting(),
              const ItemDrawer(
                title: 'الايات المحفوظة',
                iconData: FlutterIslamicIcons.quran2,
                screen: AyaSavedScreen(),
                subtitle: 'انتقل الى الايات المحفوظة',
              ),
              const ItemDrawer(
                title: 'أذكاري الخاصة',
                iconData: Icons.event_note_sharp,
                screen: Azkary(),
                subtitle: 'انتقل الى الأذكار الخاصة بك',
              ),
              const ItemDrawer(
                title: 'صلاوات',
                iconData: FlutterIslamicIcons.solidMohammad,
                screen: PrayOfMohammedScreen(),
                subtitle:
                    'انتقل الى صلاوات على النبي محمد عليه الصلاو و السلام',
              ),
              const ItemDrawer(
                title: 'صلة الرحم',
                iconData: FlutterIslamicIcons.family,
                screen: PrayOfMohammedScreen(),
                subtitle:
                    'انتقل الى صلة الرحم و معلومات عنها في الدين ..',
              ),
              Divider(color: MyConstant.kPrimary),
              ItemDrawer(
                screen: AzkarList(dataOfAzkar: DataOfAzkar.azkarItems[0]),
                title: 'أذكار الصباح',
                subtitle: 'انتقل الى اذكار الصباح ...',
                iconData: FlutterIslamicIcons.mohammad,
              ),
              ItemDrawer(
                screen: AzkarList(dataOfAzkar: DataOfAzkar.azkarItems[1]),
                title: 'أذكار المساء',
                subtitle: 'انتقل الى اذكار المساء ...',
                iconData: FlutterIslamicIcons.mohammad,
              ),
              Divider(color: MyConstant.kPrimary),
              Text(
                'Made By Nahed Oukal ©',
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontFamily: 'ggess',
                    color: MyConstant.kPrimary,
                    fontSize: 14.sp),
              )
            ],
          ),
        );
      },
    );
  }
}
