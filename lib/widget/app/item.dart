import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.grey.shade100,
      color: MyConstant.kWhite,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'ggess',
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: MyConstant.kPrimary,
              overflow: TextOverflow.ellipsis
            ),
            // textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
