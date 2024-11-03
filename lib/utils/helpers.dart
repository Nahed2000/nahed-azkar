import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/azkar.dart';
import '../services/constant.dart';
import '../widget/app/service/copy_button.dart';
import '../widget/app/service/share_button.dart';

mixin Helpers {
  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,textAlign: TextAlign.center),
      backgroundColor: error ? Colors.red : MyConstant.primaryColor,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
      padding: const EdgeInsetsDirectional.all(20),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsetsDirectional.all(10),
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
    ));
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
            style: TextStyle(color: MyConstant.primaryColor, fontSize: 24),
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
                      backgroundColor: MyConstant.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.h))),
                  child: Text(
                    'تم',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: MyConstant.myWhite,
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
}

//message
