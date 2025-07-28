import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    this.screen,
    this.onPress,
  });

  final String title;
  final String subtitle;
  final IconData iconData;
  final Widget? screen;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress ??
            () {
              Navigator.pop(context);
              Future.delayed(
                const Duration(milliseconds: 50),
                () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        screen ?? const Text("حدث خطا ما"),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      final tween = Tween(begin: begin, end: end);
                      final offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                ),
              );
            },
        leading: Icon(iconData, color: MyConstant.kPrimary),
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
                // overflow: TextOverflow.ellipsis,
                fontSize: 10.sp)));
  }
}
