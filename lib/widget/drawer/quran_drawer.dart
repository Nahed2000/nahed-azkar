import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screen/app/quran/sura.dart';
import '../../services/constant.dart';

class QuranDrawer extends StatelessWidget {
  const QuranDrawer(
      {super.key,
      required this.index,
      required this.title,
      required this.subtitle});

  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.pop(context);
          Future.delayed(
            const Duration(milliseconds: 30),
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuraQuran(currentIndex: index),
                  ));
            },
          );
        },
        trailing:
            Icon(Icons.arrow_forward_ios_sharp, color: MyConstant.primaryColor),
        title: Text(title,
            style: TextStyle(
                color: MyConstant.primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle,
            style: TextStyle(color: MyConstant.primaryColor, fontSize: 12.sp)));
  }
}
