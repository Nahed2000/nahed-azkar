import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/constant.dart';

class RadiosButtons extends StatelessWidget {
  const RadiosButtons({
    super.key,
    required this.icon,
    required this.onPress,
  });

  final void Function() onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPress,
        icon: Icon(icon, size: 48.w, color: MyConstant.primaryColor));
  }
}
