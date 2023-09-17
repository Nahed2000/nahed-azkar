import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      padding: EdgeInsets.all(15.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyConstant.myWhite,
        borderRadius: BorderRadius.circular(22.h),
        border: Border.all(
          color: MyConstant.primaryColor,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19.sp,
            color: MyConstant.primaryColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
