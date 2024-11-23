import 'package:flutter/material.dart';

class QuranActionButton extends StatelessWidget {
  const QuranActionButton(
      {super.key,
      required this.widget,
      required this.suraNumber,
      required this.iconData,
      this.size = 24});

  final Widget widget;
  final int suraNumber;
  final IconData iconData;

  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget)),
        icon: Icon(iconData, size: size));
  }
}
