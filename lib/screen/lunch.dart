import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/constant.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
  Future.delayed(
    const Duration(seconds: 1),
    () => Navigator.pushReplacementNamed(context, '/home_app_screen'),
  );
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/appicon.png',
              height: 270.h,
            ),
            Text(
              '" قَالَ بَلَىٰ وَلَٰكِن لِّيَطْمَئِنَّ قَلْبِي ۖ  " ',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: MyConstant.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              ' © Made By Eco Kids Team',
              style: TextStyle(color: MyConstant.primaryColor, fontSize: 15.w),
            )
          ],
        ),
      ),
    );
  }
}
