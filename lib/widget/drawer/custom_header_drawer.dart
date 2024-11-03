import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class CustomHeaderDrawer extends StatelessWidget {
  const CustomHeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/mo1.jpg'),
            colorFilter:
                ColorFilter.mode(MyConstant.primaryColor, BlendMode.color),
            fit: BoxFit.fill,
          ),
        ),
        child: Card(
          elevation: 4,
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.h)),
          child: ListTile(
            title: Text(
              'لِّيَطْمَئِنَّ قَلْبِي',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '" قَالَ بَلَىٰ وَلَٰكِن لِّيَطْمَئِنَّ قَلْبِي ۖ " ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
