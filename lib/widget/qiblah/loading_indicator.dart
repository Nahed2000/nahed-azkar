import 'package:flutter/material.dart';

import '../../services/constant.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: MyConstant.primaryColor,
        ),
      );
}
