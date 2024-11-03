import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

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
    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.white,
      color: MyConstant.myWhite,
      shape: OutlineInputBorder(
        borderSide: BorderSide(width: 0.2, color: MyConstant.primaryColor),
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: SwitchListTile.adaptive(
        contentPadding: EdgeInsets.all(20.w),
        title: Text(
          title,
          style: TextStyle(
              color: MyConstant.primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: MyConstant.myGrey)),
        value: value,
        onChanged: onPress,
        activeColor: MyConstant.primaryColor,
        inactiveTrackColor: MyConstant.myGrey,
        inactiveThumbColor: Colors.white54,
      ),
    );
  }
}
