import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/api_response.dart';
import '../../services/constant.dart';
import '../app/service/copy_button.dart';
import '../app/service/share_button.dart';

class TafserAya extends StatelessWidget {
  const TafserAya({
    super.key,
    required this.apiResponse,
  });

  final ApiResponse apiResponse;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.w)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'التفسير الميسر',
            style: TextStyle(fontFamily: 'ggess',color: MyConstant.kPrimary),
          ),
          Icon(FlutterIslamicIcons.islam, color: MyConstant.kPrimary)
        ],
      ),
      content: SingleChildScrollView(
        child: Text(apiResponse.message, style: TextStyle(fontFamily: 'ggess',fontSize: 18.w)),
      ),
      backgroundColor: MyConstant.kWhite,
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ShareButton(text: apiResponse.message),
        CopyButton(textCopy: apiResponse.message, textMessage: 'تم نسخ الذكر'),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Text('تم',
                style: TextStyle(fontFamily: 'ggess',
                    color: Colors.red,
                    fontSize: 16.w,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}
