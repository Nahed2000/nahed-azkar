import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:nahed_azkar/widget/drawer/azkar_drawer.dart';
import 'package:nahed_azkar/widget/drawer/custom_header_drawer.dart';

import '../../cubit/home_cubit/home_cubit.dart';
import '../../cubit/home_cubit/home_state.dart';
import '../../widget/drawer/quran_drawer.dart';
import '../../widget/drawer/social_media_drawer.dart';
import '../../widget/drawer/text_drawer.dart';

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
              const TextDrawer(text: 'سنن قرآنية'),
              const QuranDrawer(
                  title: 'سورة البقرة',
                  subtitle: 'انتقل الى قراءة سورة البقرة',
                  index: 2),
              const QuranDrawer(
                  title: 'سورة الكهف',
                  subtitle: 'انتقل الى قراءة سورة الكهف',
                  index: 18),
              const QuranDrawer(
                  title: 'سورة الملك',
                  subtitle: 'انتقل الى قراءة سورة الملك',
                  index: 67),
              Divider(color: MyConstant.kPrimary),
              const AzkarDrawer(
                  index: 0,
                  title: 'أذكار الصباح',
                  subtitle: 'انتقل الى اذكار الصباح ...'),
              const AzkarDrawer(
                  index: 1,
                  title: 'أذكار المساء',
                  subtitle: 'انتقل الى اذكار المساء ...'),
              Divider(color: MyConstant.kPrimary),
              const TextDrawer(text: 'للتواصل و الإقتراح'),
              SocialMediaDrawer(),
              Divider(color: MyConstant.kPrimary),
              Text(
                'By : Made By Eco Kids Team ©',
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
