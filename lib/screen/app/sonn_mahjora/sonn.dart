import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/constant.dart';
import '../../../data/sonn.dart';
import '../../../widget/app/item.dart';
import '../../../widget/custom_appbar.dart';
import 'sonn_list.dart';

class SonnMahjoraScreen extends StatelessWidget {
  const SonnMahjoraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, 'سنن مهجورة', bnbar: false),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SonnListScreen(sonnModel: DataOfSonn.listItem[index])));
          },
          child: ItemsScreen(text: DataOfSonn.listItem[index].title),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
        itemCount: DataOfSonn.listItem.length,
      ),
    );
  }
}
