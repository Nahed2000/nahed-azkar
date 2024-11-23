import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/screen/home/my_azkar/azkary.dart';

import '../../../services/constant.dart';
import '../../../data/azkar.dart';
import '../../../widget/custom_appbar.dart';
import 'azkar_list.dart';

class AzkarScreen extends StatelessWidget with CustomsAppBar {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: settingsAppBar(context: context, title: 'أذكار المسلم'),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Widget rout = index == 15
                ? const Azkary()
                : AzkarList(dataOfAzkar: DataOfAzkar.azkarItems[index]);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => rout));
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            color: MyConstant.kWhite,
            shadowColor: MyConstant.kPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: MyConstant.kPrimary, width: 0.1),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40.h,
                    child: index == 0 ||
                            index == 3 ||
                            index == 4 ||
                            index == 12 ||
                            index == 8
                        ? Image.asset(
                            DataOfAzkar.iconList[index],
                            color: MyConstant.kPrimary,
                          )
                        : Icon(
                            DataOfAzkar.iconList[index],
                            size: 40.h,
                            color: MyConstant.kPrimary,
                          ),
                  ),
                  Text(
                    DataOfAzkar.azkarItems[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'ggess',
                        fontSize: 18.sp,
                        color: MyConstant.kPrimary,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
        ),
        itemCount: DataOfAzkar.azkarItems.length,
      ),
    );
  }
}
