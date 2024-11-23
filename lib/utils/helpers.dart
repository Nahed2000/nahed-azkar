import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/home_cubit/home_cubit.dart';
import '../cubit/home_cubit/home_state.dart';
import '../data/azkar.dart';
import '../services/constant.dart';
import '../widget/app/service/copy_button.dart';
import '../widget/app/service/share_button.dart';

mixin Helpers {
  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message,
            style: TextStyle(
                fontFamily: 'ggess', color: Colors.white, fontSize: 14.sp),
            textAlign: TextAlign.center),
        backgroundColor: error ? Colors.red : MyConstant.kPrimary,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 2),
        padding: const EdgeInsetsDirectional.all(10),
        elevation: 8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        showCloseIcon: true,
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        int randomIndex = Random().nextInt(DataOfAzkar.randomZikr.length);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.w),
          ),
          title: Text(
            'لِّيَطْمَئِنَّ قَلْبِي',
            style: TextStyle(
                fontFamily: 'uthmanic',
                color: MyConstant.kPrimary,
                fontSize: 24),
          ),
          content: Text(DataOfAzkar.randomZikr[randomIndex][0]),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShareButton(text: DataOfAzkar.randomZikr[randomIndex][0]),
                CopyButton(
                    textCopy: DataOfAzkar.randomZikr[randomIndex][0],
                    textMessage: 'تم نسخ الذكر'),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyConstant.kPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.h))),
                  child: Text(
                    'تم',
                    style: TextStyle(
                        fontFamily: 'ggess',
                        fontSize: 14.sp,
                        color: MyConstant.kWhite,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  static void showTextChanger(BuildContext context) {
    showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.w), topRight: Radius.circular(50.w))),
      builder: (context) => BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Container(
            color: MyConstant.kWhite,
            alignment: Alignment.center,
            height: 170.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('تغير حجم الخط',
                    style: TextStyle(
                      fontFamily: 'ggess',
                      color: MyConstant.kPrimary,
                      fontSize: 18.sp,
                    )),
                Slider(
                  activeColor: MyConstant.kPrimary,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    BlocProvider.of<HomeCubit>(context).changeTextSize(value);
                  },
                  value: BlocProvider.of<HomeCubit>(context).sizeText,
                  min: 18,
                  max: 40,
                ),
              ],
            ),
          );
        },
      ),
      context: context,
    );
  }
}
