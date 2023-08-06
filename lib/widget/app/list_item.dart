import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/constant.dart';

class ListItems extends StatelessWidget {
  const ListItems({
    Key? key,
    required this.screen,
    required this.listItem,
  }) : super(key: key);
  final Widget screen;
  final List listItem;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            )),
        child: Container(
          height: 100.h,
          width: double.infinity,
          padding: EdgeInsets.all(15.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MyConstant.myWhite,
            borderRadius: BorderRadius.circular(22.h),
            border: Border.all(
              color: MyConstant.primaryColor,
            ),
          ),
          child: Text(
            listItem[index],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19.sp,
                color: MyConstant.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 15.h),
      itemCount: listItem.length,
    );
  }
}
