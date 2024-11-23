import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class TextDrawer extends StatelessWidget {
  const TextDrawer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontFamily: 'ggess',color: MyConstant.kPrimary, fontSize: 15.h),
      ),
    );
  }
}
