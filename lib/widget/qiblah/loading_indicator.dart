import 'package:flutter/material.dart';

import '../../services/constant.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator.adaptive(
                backgroundColor: MyConstant.kPrimary),
            const SizedBox(height: 20),
            Text(
              'انتظر بعض الوقت لتحديد القبلة.. ',
              style: TextStyle(fontFamily: 'ggess',color: MyConstant.kPrimary, fontSize: 22),
            )
          ],
        ),
      );
}
