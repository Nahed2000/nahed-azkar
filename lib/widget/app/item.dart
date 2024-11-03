import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Card(
        elevation: 6,
        shadowColor: Colors.grey.shade100,
        color: MyConstant.myWhite,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.h),
          side: BorderSide(
            color: MyConstant.primaryColor,
            width: 0.2,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: MyConstant.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
