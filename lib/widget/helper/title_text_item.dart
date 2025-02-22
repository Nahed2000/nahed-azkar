import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class TitleTextItem extends StatelessWidget {
  const TitleTextItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'ggess',
        color: MyConstant.kPrimary,
        fontSize: 18.sp,
      ),
    );
  }
}
