import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';

import '../../cubit/home_cubit/home_state.dart';
import '../../services/constant.dart';
import '../../cubit/home_cubit/home_cubit.dart';
import '../../data/pray_of_mohammed.dart';
import '../../widget/app/service/copy_button.dart';
import '../../widget/app/service/share_button.dart';

class PrayOfMohammedScreen extends StatelessWidget with CustomsAppBar {
  const PrayOfMohammedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: customAppBar(
          title: 'الصلاة على الرسول',
          changeText: true,
          context: context),
      body: ListView.separated(
        padding: EdgeInsets.all(20.h),
        itemBuilder: (context, index) => Card(
          color: MyConstant.kWhite,
          elevation: 6,
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
                      PrayOfMohammed.prayOfMohammed[index],
                      style: TextStyle(fontFamily: 'ggess',
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
                    ShareButton(text: PrayOfMohammed.prayOfMohammed[index]),
                    CopyButton(
                        textCopy: PrayOfMohammed.prayOfMohammed[index],
                        textMessage: 'تم نسخ الصلاة'),
                    CircleAvatar(
                      radius: 20.h,
                      backgroundColor: MyConstant.kPrimary,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(fontFamily: 'ggess',color: MyConstant.kWhite),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        itemCount: PrayOfMohammed.prayOfMohammed.length,
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
      ),
    );
  }
}
