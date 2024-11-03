import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class ListSettingsItems extends StatelessWidget {
  const ListSettingsItems({
    super.key,
    required this.title,
    required this.item,
  });

  final String title;

  final List<Widget> item;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: MyConstant.primaryColor,
      collapsedIconColor: MyConstant.primaryColor,
      title: Text(
        title,
        style: TextStyle(
          color: MyConstant.primaryColor,
          fontSize: 16.h,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: item,
    );
  }
}
