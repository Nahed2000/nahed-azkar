import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class PrayTimeText extends StatelessWidget {
  const PrayTimeText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.time = '0',
    this.isShowTimer = false,
  });

  final String firstText;
  final String secondText;
  final bool isShowTimer;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(firstText,
            style: TextStyle(
                fontFamily: 'ggess',
                color: MyConstant.kPrimary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700)),
        Visibility(
          visible: isShowTimer,
          child: Text(time,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: time == '0' ? 'ggess' : null,
                  color: MyConstant.kBlack)),
        ),
        Text(
          secondText,
          style: TextStyle(
            color: MyConstant.kPrimary,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
