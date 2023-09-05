import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MsaderItem extends StatelessWidget {
  const MsaderItem({
    required this.onPress,
    required this.title,
    super.key,
  });

  final void Function() onPress;
  final String  title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style:
        TextStyle(color: Colors.blue, fontSize: 18.sp),
      ),
    );
  }
}