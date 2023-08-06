import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/ayat.dart';
import '../../../../widget/app/item.dart';
import '../../../services/constant.dart';
import '../../../widget/custom_appbar.dart';
import 'ayat_list.dart';

class AyatScreen extends StatelessWidget {
  const AyatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, 'آيات من القرآن', bnbar: false),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AyatList(ayatModel: DataOfAyat.ayatList[index]),
              )),
          child: ItemsScreen(text: DataOfAyat.ayatList[index].title),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 13.h),
        itemCount: DataOfAyat.ayatList.length,
      ),
    );
  }
}
