import 'package:flutter/material.dart';

import '../../services/constant.dart';

class ZakatSubTitle extends StatelessWidget {
  const ZakatSubTitle({super.key, required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(subtitle,
        style: TextStyle(
            fontSize: 16,
            color: MyConstant.kPrimary,
            fontWeight: FontWeight.w500));
  }
}
