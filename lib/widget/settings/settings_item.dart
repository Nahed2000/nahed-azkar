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
      color: MyConstant.kWhite,
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: ListTile(
        selectedColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(13),
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
        trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey),
      ),
    );
  }
}
