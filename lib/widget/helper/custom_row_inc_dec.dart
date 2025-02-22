import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/widget/helper/title_text_item.dart';

import '../changer_text.dart';

class CustomRowIncDec extends StatelessWidget {
  const CustomRowIncDec({
    super.key,
    required this.title,
    required this.incPress,
    required this.decPress,
  });

  final String title;

  final void Function() incPress;
  final void Function() decPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleTextItem(title: title),
        const Spacer(),
        ChangerTextButton(
            iconText: '+', onPress: incPress, heroTag: '$title incTxt'),
        SizedBox(width: 10.w),
        ChangerTextButton(
            iconText: '-', onPress: decPress, heroTag: '$title decTxt'),
      ],
    );
  }
}
