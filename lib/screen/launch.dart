import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/constant.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..forward();
    Future.delayed(
      const Duration(milliseconds: 1800),
          () =>
      mounted
          ? Navigator.pushReplacementNamed(context, '/home_app_screen')
          : null,
    );
    super.initState();
  }

  late AnimationController animationController;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      body: FadeTransition(
        opacity: animationController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizeTransition(
              sizeFactor: animationController,
              child: Center(
                child: Image.asset(
                  'assets/images/appicon.png',
                  height: 270.h,
                ),
              ),
            ),
            Text(
              '" قَالَ بَلَىٰ وَلَٰكِن لِّيَطْمَئِنَّ قَلْبِي ۖ " ',
              style: TextStyle(
                fontFamily: 'uthmanic',
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: MyConstant.kPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              ' © Made By Eco Kids Team',
              style: TextStyle(
                  fontFamily: 'ggess',
                  color: MyConstant.kPrimary,
                  fontSize: 15.w),
            )
          ],
        ),
      ),
    );
  }
}
