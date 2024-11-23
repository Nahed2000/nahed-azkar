import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../../services/constant.dart';
import '../../widget/app/home/hijri_item.dart';
import '../../widget/custom_appbar.dart';

class HijriCalendarScreen extends StatelessWidget with CustomsAppBar {
  const HijriCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('ar');
    HijriCalendar hijriDate = HijriCalendar.now();
    DateTime now = DateTime.now();
    DateFormat arabicDateFormat = DateFormat('EEEE, d MMMM y', 'ar');
    String arabicDate = arabicDateFormat.format(now);

    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: settingsAppBar(context: context, title: 'التوقيت الهجري'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'توقيت اليوم الهجري ',
              style: TextStyle(
                  fontFamily: 'ggess',
                  fontSize: 18.sp,
                  color: MyConstant.kPrimary,
                  fontWeight: FontWeight.bold),
            ),
            HijriItem(
                title:
                    ' تاريخ اليوم : ${hijriDate.hDay},${hijriDate.longMonthName}, ${hijriDate.hYear} هـ '),
            SizedBox(height: 20.h),
            Text(
              'توقيت اليوم الميلادي ',
              style: TextStyle(
                  fontFamily: 'ggess',
                  fontSize: 18.sp,
                  color: MyConstant.kPrimary,
                  fontWeight: FontWeight.bold),
            ),
            HijriItem(title: 'تاريخ اليوم : $arabicDate')
          ],
        ),
      ),
    );
  }
}
