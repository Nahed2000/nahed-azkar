import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/constant.dart';

class PrayTimeText extends StatelessWidget {
  const PrayTimeText({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstText,
          style: TextStyle(
            color: MyConstant.primaryColor,
            fontSize: 14.h,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          secondText,
          style: TextStyle(
            color: MyConstant.primaryColor,
            fontSize: 14.h,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
