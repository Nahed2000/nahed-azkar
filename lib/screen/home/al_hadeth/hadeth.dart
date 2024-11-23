import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widget/app/item.dart';
import '../../../services/constant.dart';
import '../../../data/hadeth.dart';
import '../../../widget/custom_appbar.dart';
import 'hadeth_list.dart';

class AlHadethScreen extends StatelessWidget with CustomsAppBar{
  const AlHadethScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: settingsAppBar(context:context,title: 'أحاديث نبوية شريفة'),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HadethList(dataOfHadeth: DataOfHadeth.hadethItem[index]),
                ));
          },
          child: ItemsScreen(text: DataOfHadeth.hadethItem[index].title),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
        itemCount: 5,
      ),
    );
  }
}
