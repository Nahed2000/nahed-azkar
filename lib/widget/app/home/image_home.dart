import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/constant.dart';

class ImageHome extends StatelessWidget {
  const ImageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      alignment: Alignment.center,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
        image: DecorationImage(
          image: const AssetImage('assets/images/mo1.jpg'),
          colorFilter: ColorFilter.mode(MyConstant.kPrimary, BlendMode.color),
          fit: BoxFit.fill,
        ),
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 4,
        margin: const EdgeInsets.all(20),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
        child: ListTile(
          contentPadding: EdgeInsets.all(5.w),
          title: Text(
            'لِّيَطْمَئِنَّ قَلْبِي',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'uthmanic',
              color: Colors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '" قَالَ بَلَىٰ وَلَٰكِن لِّيَطْمَئِنَّ قَلْبِي ۖ " ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'ggess',
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
