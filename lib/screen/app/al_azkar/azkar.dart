import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/constant.dart';
import '../../../data/azkar.dart';
import '../../../widget/custom_appbar.dart';
import 'azkar_list.dart';

class AzkarScreen extends StatelessWidget with CustomsAppBar {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: settingsAppBar(context: context, title: 'أذكار المسلم'),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AzkarList(dataOfAzkar: DataOfAzkar.azkarItems[index]),
              )),
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            color: MyConstant.myWhite,
            shadowColor: MyConstant.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: MyConstant.primaryColor, width: 0.1),
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
                            color: MyConstant.primaryColor,
                          )
                        : Icon(
                            DataOfAzkar.iconList[index],
                            size: 40.h,
                            color: MyConstant.primaryColor,
                          ),
                  ),
                  Text(
                    DataOfAzkar.azkarItems[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: MyConstant.primaryColor,
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
