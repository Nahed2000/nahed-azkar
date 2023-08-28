import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/constant.dart';

class NotificationItems extends StatelessWidget {
  const NotificationItems({
    super.key,
    required this.subtitle,
    required this.title,
    required this.value,
    required this.onPress,
  });

  final String title;
  final String subtitle;
  final bool value;
  final void Function(bool value) onPress;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.w),
          borderSide: BorderSide(color: MyConstant.myGrey)),
      title: Text(
        title,
        style: TextStyle(
          color: MyConstant.myBlack,
          fontSize: 16.sp,
        ),
      ),
      subtitle: Text(subtitle, style: TextStyle(color: MyConstant.myGrey)),
      value: value,
      onChanged: onPress,
      activeColor: MyConstant.primaryColor,
      inactiveTrackColor: MyConstant.myGrey,
      inactiveThumbColor: Colors.white54,
    );
  }
}
