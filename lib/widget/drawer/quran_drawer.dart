import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screen/home/quran/sura.dart';
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
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sura(currentIndex: index),
                  ));
            },
          );
        },
        leading:
            Icon(FlutterIslamicIcons.quran, color: MyConstant.kPrimary),
        trailing:
            Icon(Icons.arrow_forward_ios_sharp, color: MyConstant.kPrimary),
        title: Text(title,
            style: TextStyle(
                fontFamily: 'ggess',
                color: MyConstant.kPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle,
            style: TextStyle(
                fontFamily: 'ggess',
                color: MyConstant.kPrimary,
                fontSize: 10.sp)));
  }
}
