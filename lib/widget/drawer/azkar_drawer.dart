import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/azkar.dart';
import '../../screen/home/al_azkar/azkar_list.dart';
import '../../services/constant.dart';

class AzkarDrawer extends StatelessWidget {
  const AzkarDrawer(
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
            const Duration(milliseconds: 50),
            () =>

                Navigator.push(
                  // ignore: use_build_context_synchronously
                    context,
                MaterialPageRoute(
                    builder: (context) =>
                        AzkarList(dataOfAzkar: DataOfAzkar.azkarItems[index]))),
          );
        },
        leading:
            Icon(FlutterIslamicIcons.mohammad, color: MyConstant.kPrimary),
        trailing:
            Icon(Icons.arrow_forward_ios_sharp, color: MyConstant.kPrimary),
        title: Text(title,
            style: TextStyle(fontFamily: 'ggess',
                color: MyConstant.kPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle,
            style: TextStyle(fontFamily: 'ggess',color: MyConstant.kPrimary, fontSize: 10.sp)));
  }
}
