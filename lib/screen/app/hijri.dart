import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../../services/constant.dart';
import '../../widget/custom_appbar.dart';

class HijriCalendarScreen extends StatelessWidget {
  const HijriCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('ar');
    HijriCalendar hijriDate = HijriCalendar.now();
    DateTime now = DateTime.now();
    DateFormat arabicDateFormat = DateFormat('EEEE, d MMMM y', 'ar');
    String arabicDate = arabicDateFormat.format(now);

    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, 'التوقيت الهجري', bnbar: false),
      body: ListView(
        padding: EdgeInsets.all(20.h),
        children: [
          SizedBox(
            height: 30.h,
            child: Text(
              'توقيت اليوم الهجري ',
              style: TextStyle(
                  fontSize: 18.sp,
                  color: MyConstant.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100.h,
            width: double.infinity,
            padding: EdgeInsets.all(15.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // color: ,
                borderRadius: BorderRadius.circular(22.h),
                border: Border.all(width: 2, color: MyConstant.primaryColor)),
            child: Text(
              // DataOfAzkar.azkarItems[index].title,
              ' تاريخ اليوم : ${hijriDate.hDay},${hijriDate.longMonthName}, ${hijriDate.hYear} هـ ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  color: MyConstant.primaryColor),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 30.h,
            child: Text(
              'توقيت اليوم الميلادي ',
              style: TextStyle(
                  fontSize: 18.sp,
                  color: MyConstant.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100.h,
            width: double.infinity,
            padding: EdgeInsets.all(15.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // color: ,
                borderRadius: BorderRadius.circular(22.h),
                border: Border.all(width: 2, color: MyConstant.primaryColor)),
            child: Text(
              // DataOfAzkar.azkarItems[index].title,
              'تاريخ اليوم : $arabicDate',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  color: MyConstant.primaryColor),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
