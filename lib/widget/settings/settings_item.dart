import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.title,
      required this.icon,
      this.onPress,
      this.image,
      this.routeScreen});

  final String title;
  final String? image;
  final String? routeScreen;
  final IconData icon;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: UnderlineInputBorder(
          borderSide: BorderSide(color: MyConstant.kPrimary, width: 0.5)),
      child: ListTile(
        onTap: onPress ?? () => Navigator.pushNamed(context, "$routeScreen"),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'ggess',
            color: MyConstant.kPrimary,
            fontSize: 15.sp,
          ),
        ),
        leading: image == null
            ? Icon(icon, color: MyConstant.kPrimary)
            : Image.asset(image!,
                height: 24.h, width: 24.w, color: MyConstant.kGrey),
      ),
    );
  }
}
