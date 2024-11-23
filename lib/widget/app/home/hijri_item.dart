import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/constant.dart';

class HijriItem extends StatelessWidget {
  const HijriItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Card(
        elevation: 6,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.white,
        color: MyConstant.kWhite,
        shape: OutlineInputBorder(
          borderSide: BorderSide(width: 0.2, color: MyConstant.kPrimary),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontFamily: 'ggess',
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: MyConstant.kPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
