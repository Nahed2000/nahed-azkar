import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubit/home_cubit/home_cubit.dart';
import '../../../widget/app/service/copy_button.dart';
import '../../../cubit/home_cubit/home_state.dart';
import '../../../services/constant.dart';
import '../../../model/app/selat_rahem.dart';
import '../../../widget/app/service/share_button.dart';
import '../../../widget/custom_appbar.dart';

class SelatRahemList extends StatelessWidget with CustomsAppBar {
  const SelatRahemList({Key? key, required this.selatRahemModel})
      : super(key: key);
  final SelatRahemModel selatRahemModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: customAppBar(
          context: context, title: selatRahemModel.name, changeText: true),
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Text(
                      selatRahemModel.listData[index],
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ShareButton(text: selatRahemModel.listData[index]),
                    CopyButton(
                        textMessage: 'تم نسخ النص',
                        textCopy: selatRahemModel.listData[index]),
                    CircleAvatar(
                        radius: 20.h,
                        backgroundColor: MyConstant.kPrimary,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(fontFamily: 'ggess',color: MyConstant.kWhite),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        itemCount: selatRahemModel.listData.length,
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
      ),
    );
  }
}
