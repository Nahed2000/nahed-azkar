import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class EmptyColumn extends StatelessWidget {
  const EmptyColumn({
    super.key,
    required this.title,
    this.onPress,
    this.titleButton,
  });

  final String title;
  final String? titleButton;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning, color: Colors.red, size: 120.h),
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyle(
            color: MyConstant.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Visibility(
          replacement: const SizedBox(),
          visible: titleButton != null,
          child: ElevatedButton(
            onPressed: onPress,
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
                backgroundColor: MyConstant.primaryColor,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: Text(
              titleButton??'',
              style: TextStyle(
                color: MyConstant.myWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
