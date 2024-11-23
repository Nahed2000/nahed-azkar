import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../cubit/home_cubit/home_state.dart';
import '../../../utils/helpers.dart';
import '../../../widget/app/service/copy_button.dart';
import '../../../widget/app/service/share_button.dart';
import '../../../model/azkar.dart';
import '../../../services/constant.dart';
import '../../../cubit/home_cubit/home_cubit.dart';
import '../../../widget/custom_appbar.dart';

class AzkarList extends StatefulWidget {
  const AzkarList({Key? key, required this.dataOfAzkar}) : super(key: key);
  final AzkarModel dataOfAzkar;

  @override
  State<AzkarList> createState() => _AzkarListState();
}

class _AzkarListState extends State<AzkarList> with CustomsAppBar, Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: customAppBar(
          context: context, title: widget.dataOfAzkar.title, changeText: true),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        itemBuilder: (context, index) => InkWell(
          autofocus: true,
          highlightColor: MyConstant.kPrimary,
          splashColor: MyConstant.kPrimary,
          onTap: () {
            setState(() {
              if (widget.dataOfAzkar.azkarItems[index][1] > 0) {
                widget.dataOfAzkar.azkarItems[index][1]--;
                HapticFeedback.heavyImpact();
              }
              if (widget.dataOfAzkar.azkarItems[index][1] == 0) {
                showSnackBar(context, message: 'تم قراءة الذكر');
              }
            });
          },
          child: Card(
            elevation: 6,
            color: widget.dataOfAzkar.azkarItems[index][1] != 0
                ? MyConstant.kWhite
                : Colors.grey.shade400,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(width: 0.1, color: MyConstant.kPrimary)),
            child: Padding(
              padding: EdgeInsets.all(20.0.w),
              child: Column(
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Text(
                        widget.dataOfAzkar.azkarItems[index][0],
                        style: TextStyle(
                            fontFamily: 'ggess',
                            fontSize:
                                BlocProvider.of<HomeCubit>(context).sizeText,
                            color: MyConstant.kBlack),
                        textAlign: TextAlign.justify,
                      );
                    },
                  ),
                  SizedBox(height: 5.h),
                  Divider(color: MyConstant.kPrimary, thickness: 3),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CopyButton(
                          textCopy: widget.dataOfAzkar.azkarItems[index][0],
                          textMessage: 'تم نسخ الذكر'),
                      ShareButton(
                          text: widget.dataOfAzkar.azkarItems[index][0]),
                      CircleAvatar(
                          radius: 20.h,
                          backgroundColor: MyConstant.kPrimary,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                                fontFamily: 'ggess', color: MyConstant.kWhite),
                          )),
                      Container(
                        alignment: Alignment.center,
                        height: 45.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            color: MyConstant.kPrimary,
                            borderRadius: BorderRadius.circular(15.h)),
                        child: Text(
                          widget.dataOfAzkar.azkarItems[index][1] != 0
                              ? 'عدد التكرار \n${widget.dataOfAzkar.azkarItems[index][1].toString()}'
                              : 'تم',
                          style: TextStyle(
                              fontFamily: 'ggess',
                              color: MyConstant.kWhite,
                              fontSize: 10.sp),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        itemCount: widget.dataOfAzkar.azkarItems.length,
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
      ),
    );
  }
}
