import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../cubit/home_state.dart';
import '../../../../widget/app/copy_button.dart';
import '../../../../widget/app/share_button.dart';
import '../../../model/azkar/azkar.dart';
import '../../../services/constant.dart';
import '../../../cubit/home_cubit.dart';
import '../../../widget/custom_appbar.dart';

class AzkarList extends StatefulWidget {
  const AzkarList({Key? key, required this.dataOfAzkar}) : super(key: key);
  final AzkarModel dataOfAzkar;

  @override
  State<AzkarList> createState() => _AzkarListState();
}

class _AzkarListState extends State<AzkarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, widget.dataOfAzkar.title,
          bnbar: false, changeText: true),
      body: ListView.separated(
        padding: EdgeInsets.all(20.h),
        itemBuilder: (context, index) => InkWell(
        autofocus: true,
          onTap: () => setState(() {
            if (widget.dataOfAzkar.azkarItems[index][1] > 0) {
              widget.dataOfAzkar.azkarItems[index][1]--;
            }
          }),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.h),
            decoration: BoxDecoration(
                color: widget.dataOfAzkar.azkarItems[index][1] != 0
                    ? MyConstant.myWhite
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(width: 1, color: MyConstant.primaryColor)),
            child: Column(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Text(
                      widget.dataOfAzkar.azkarItems[index][0],
                      style: TextStyle(
                          fontSize:
                              BlocProvider.of<HomeCubit>(context).sizeText,
                          color: MyConstant.myBlack),
                      textAlign: TextAlign.justify,
                    );
                  },
                ),
                SizedBox(height: 5.h),
                Divider(color: MyConstant.primaryColor, thickness: 3),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CopyButton(
                        textCopy: widget.dataOfAzkar.azkarItems[index][0],
                        textMessage: 'تم نسخ الذكر'),
                    ShareButton(text: widget.dataOfAzkar.azkarItems[index][0]),
                    CircleAvatar(
                        radius: 20.h,
                        backgroundColor: MyConstant.primaryColor,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(color: MyConstant.myWhite),
                        )),
                    Container(
                      alignment: Alignment.center,
                      height: 45.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                          color: MyConstant.primaryColor,
                          borderRadius: BorderRadius.circular(15.h)),
                      child: Text(
                        widget.dataOfAzkar.azkarItems[index][1] != 0
                            ? 'عدد التكرار \n${widget.dataOfAzkar.azkarItems[index][1].toString()}'
                            : 'تم',
                        style: TextStyle(color: MyConstant.myWhite),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        itemCount: widget.dataOfAzkar.azkarItems.length,
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
      ),
    );
  }
}
