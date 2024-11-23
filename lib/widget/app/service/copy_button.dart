import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nahed_azkar/utils/helpers.dart';

import '../../../services/constant.dart';

class CopyButton extends StatelessWidget with Helpers {
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
        showSnackBar(context, message: textMessage);
      },
      icon: Icon(Icons.copy, color: MyConstant.kPrimary),
    );
  }
}
