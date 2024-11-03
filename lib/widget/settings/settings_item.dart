import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress,
      this.image});

  final String title;
  final String? image;
  final IconData icon;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: UnderlineInputBorder(
          borderSide: BorderSide(color: MyConstant.primaryColor, width: 0.5)),
      child: ListTile(
        onTap: onPress,
        title: Text(
          title,
          style: TextStyle(
            color: MyConstant.primaryColor,
            fontSize: 17.w,
          ),
        ),
        leading: image == null
            ? Icon(icon, color: MyConstant.primaryColor)
            : Image.asset(image!,
                height: 24.h, width: 24.w, color: MyConstant.myGrey),
      ),
    );
  }
}
