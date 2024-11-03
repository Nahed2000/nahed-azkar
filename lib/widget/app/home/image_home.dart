import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/constant.dart';

class ImageHome extends StatelessWidget {
  const ImageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.h,
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
          image: const AssetImage(
            'assets/images/mo1.jpg',
          ),
          colorFilter:
              ColorFilter.mode(MyConstant.primaryColor, BlendMode.color),
          fit: BoxFit.fill,
        ),
      ),
      child: Card(
        color: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
        child: Padding(
          padding: EdgeInsets.all(10.0.h),
          child: Text(
            'سَبِّحِ ٱسۡمَ رَبِّكَ ٱلۡأَعۡلَى',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
