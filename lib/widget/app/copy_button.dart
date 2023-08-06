import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class CopyButton extends StatelessWidget {
  const CopyButton(
      {Key? key, required this.textCopy, required this.textMessage})
      : super(key: key);
  final String textCopy;
  final String textMessage;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: textCopy));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              textMessage,
              style: TextStyle(color: MyConstant.myWhite, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            backgroundColor: MyConstant.primaryColor,
          ),
        );
      },
      icon: Icon(
        Icons.copy,
        color: MyConstant.primaryColor,
      ),
    );
  }
}
