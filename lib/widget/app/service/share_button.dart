import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../services/constant.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Share.share(text);
      },
      icon: Icon(
        Icons.share,
        color: MyConstant.primaryColor,
      ),
    );
  }
}
