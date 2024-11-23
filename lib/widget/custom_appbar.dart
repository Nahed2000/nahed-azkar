import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/utils/helpers.dart';

import '../cubit/location_cubit/prayer_time_cubit.dart';
import '../services/constant.dart';

mixin CustomsAppBar {
  AppBar customAppBar({
    required BuildContext context,
    required String title,
    bool changeText = false,
    bool isPrayTime = false,
  }) {
    return AppBar(
        backgroundColor: MyConstant.kPrimary,
        toolbarHeight: 70.h,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        )),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: changeText
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios))
            : null,
        actions: [
          changeText
              ? IconButton(
                  onPressed: () => Helpers.showTextChanger(context),
                  icon: const Icon(Icons.text_fields))
              : const SizedBox(),
          isPrayTime
              ? IconButton(
                  onPressed: () => BlocProvider.of<PrayerTimeCubit>(context)
                      .getPosition(context),
                  icon: const Icon(Icons.refresh, size: 28),
                )
              : const SizedBox(),
        ],
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
              fontFamily: 'ggess',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp),
        ),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: MyConstant.kPrimary));
  }

  AppBar settingsAppBar(
      {required String title, required BuildContext context}) {
    return AppBar(
      centerTitle: true,
      backgroundColor: MyConstant.kPrimary,
      toolbarHeight: 70.h,
      title: Text(title,
          style: const TextStyle(
              fontFamily: 'uthmanic',
              color: Colors.white,
              fontWeight: FontWeight.bold)),
      elevation: 4,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios)),
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: MyConstant.kPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(520.h),
          bottomRight: Radius.circular(20.h),
        ),
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
        backgroundColor: MyConstant.kPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text('لِّيَطْمَئِنَّ قَلْبِي',
            style: TextStyle(
                fontFamily: 'uthmanic', fontSize: 25.sp, color: Colors.white)),
        toolbarHeight: 70);
  }
}
