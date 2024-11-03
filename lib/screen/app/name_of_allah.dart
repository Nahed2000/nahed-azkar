import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';
import '../../data/name_of_allah.dart';
import '../../widget/app/service/copy_button.dart';
import '../../widget/app/service/share_button.dart';
import '../../widget/custom_appbar.dart';

class NameOfAllahScreen extends StatelessWidget with CustomsAppBar {
  const NameOfAllahScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar:
          settingsAppBar(context: context, title: 'الله الذي لا إله إلا هو ..'),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shadowColor: MyConstant.myBlack,
              backgroundColor: MyConstant.myWhite,
              title: Text(
                NameOfAllah.namesOfAllah[index][0],
                style: TextStyle(
                    fontSize: 28.sp,
                    color: MyConstant.primaryColor,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Text(
                NameOfAllah.namesOfAllah[index][1],
                style: TextStyle(
                  fontSize: 16.sp,
                  color: MyConstant.myBlack,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.center,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ShareButton(
                      text: NameOfAllah.namesOfAllah[index][1],
                    ),
                    CopyButton(
                        textCopy: NameOfAllah.namesOfAllah[index][1],
                        textMessage: 'تم نسخ الإسم'),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyConstant.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.h))),
                        child: Text('تم',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: MyConstant.myWhite,
                                fontWeight: FontWeight.bold)))
                  ],
                )
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.w),
                  side: BorderSide(width: 0.2, color: MyConstant.primaryColor)),
            ),
          ),
          child: Card(
            elevation: 4,
            shadowColor: Colors.grey.shade100,
            color: MyConstant.myWhite,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: MyConstant.primaryColor, width: 0.2)),
            child: Center(
                child: Text(
              NameOfAllah.namesOfAllah[index][0],
              style: TextStyle(
                  fontSize: 18.sp,
                  color: MyConstant.primaryColor,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
        itemCount: NameOfAllah.namesOfAllah.length,
      ),
    );
  }
}
