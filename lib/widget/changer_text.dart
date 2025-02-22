import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/constant.dart';

class ChangerTextButton extends StatelessWidget {
  const ChangerTextButton({
    super.key,
    required this.heroTag,
    required this.iconText,
    required this.onPress,
  });

  final String heroTag;
  final String iconText;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPress,
      heroTag: heroTag,
      mini: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      elevation: 8,
      backgroundColor: MyConstant.kPrimary,
      child: Text(
        iconText,
        style: TextStyle(
          fontSize: 20.sp,
          color: Colors.white,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
