import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';
import '../../data/name_of_allah.dart';
import '../../widget/app/copy_button.dart';
import '../../widget/app/share_button.dart';
import '../../widget/custom_appbar.dart';

class NameOfAllahScreen extends StatelessWidget {
  const NameOfAllahScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, 'الله الذي لا إله إلا هو ..', bnbar: false),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shadowColor: MyConstant.myBlack,
              backgroundColor: MyConstant.myWhite,
              title: Text(
                NameOfAllah.namesOfAllah[index][0],
                style: TextStyle(
                    fontSize: 18.sp,
                    color: MyConstant.myBlack,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Text(NameOfAllah.namesOfAllah[index][1],
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: MyConstant.primaryColor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              alignment: Alignment.center,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ShareButton(text: NameOfAllah.namesOfAllah[index][1]),
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
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          child: Card(
            elevation: 4,
            color: MyConstant.myWhite,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: MyConstant.primaryColor)),
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
