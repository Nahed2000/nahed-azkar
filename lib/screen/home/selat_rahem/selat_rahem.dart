import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widget/app/item.dart';
import '../../../services/constant.dart';
import '../../../data/selat_rahem.dart';
import '../../../widget/custom_appbar.dart';
import 'selat_rahem_list.dart';

class SelatRahemScreen extends StatelessWidget with CustomsAppBar {
  const SelatRahemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: settingsAppBar(context: context, title: 'صلة الرحم'),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelatRahemList(
                      selatRahemModel: DataOfSelatRahem.selatRahemData[index]),
                ));
          },
          child: ItemsScreen(text: DataOfSelatRahem.selatRahemData[index].name),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
        itemCount: DataOfSelatRahem.selatRahemData.length,
      ),
    );
  }
}
