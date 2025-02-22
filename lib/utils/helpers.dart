import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/widget/custom_elevated_button.dart';

import '../cubit/home_cubit/home_cubit.dart';
import '../cubit/home_cubit/home_state.dart';
import '../data/azkar.dart';
import '../services/constant.dart';
import '../widget/app/service/copy_button.dart';
import '../widget/app/service/share_button.dart';
import '../widget/helper/custom_row_inc_dec.dart';
import '../widget/helper/title_text_item.dart';

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
          var cubit = BlocProvider.of<HomeCubit>(context);
          return Container(
            padding: const EdgeInsetsDirectional.all(20),
            color: MyConstant.kWhite,
            alignment: Alignment.center,
            height: 500.h,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TitleTextItem(title: 'اعدادت الخط'),
                SwitchListTile(
                  value: cubit.fontIsBold,
                  onChanged: (value) =>
                      BlocProvider.of<HomeCubit>(context, listen: false)
                          .changeFontText(value: value),
                  title: const TitleTextItem(title: 'الخط عريض'),
                ),
                const SizedBox(height: 10),
                CustomRowIncDec(
                  title: " حجم الخط",
                  incPress: () =>
                      BlocProvider.of<HomeCubit>(context).increaseTextSize(),
                  decPress: () =>
                      BlocProvider.of<HomeCubit>(context).decreaseSizeText(),
                ),
                SizedBox(height: 10.h),
                CustomRowIncDec(
                  title: "التباعد بين الكلمات",
                  incPress: () => BlocProvider.of<HomeCubit>(context)
                      .increaseWordSpaceText(),
                  decPress: () => BlocProvider.of<HomeCubit>(context)
                      .decreaseWordSpaceText(),
                ),
                SizedBox(height: 5.h),
                SizedBox(height: 5.h),
                const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: TitleTextItem(title: "نوع الخط"),
                ),
                SizedBox(height: 10.h),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: List.generate(
                    cubit.fontItems.length,
                    (index) => CustomElevatedButton(
                      title: cubit.fontItems[index].title,
                      onPress: () => BlocProvider.of<HomeCubit>(context,
                              listen: false)
                          .changeTextFontFamily(
                              fontFamily: cubit.fontItems[index].fontFamily),
                      fontFamily: cubit.fontItems[index].fontFamily,
                      isFont:
                          cubit.fontItems[index].fontFamily == cubit.fontFamily,
                    ),
                  ),
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
