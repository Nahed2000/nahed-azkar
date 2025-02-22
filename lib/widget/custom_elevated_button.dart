import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/services/constant.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.title,
      required this.onPress,
      required this.isFont,
      required this.fontFamily});

  final String title;
  final void Function() onPress;
  final String fontFamily;
  final bool isFont;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: ElevatedButton(
        onPressed: onPress,
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
            shape: isFont
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(width: 2, color: MyConstant.kPrimary))
                : null,
            minimumSize: Size(70.w, 40)),
        child: Text(title,
            style: TextStyle(fontSize: 18.sp, fontFamily: fontFamily)),
      ),
    );
  }
}
