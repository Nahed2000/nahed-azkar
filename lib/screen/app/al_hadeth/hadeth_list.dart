import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widget/app/service/copy_button.dart';
import '../../../widget/app/service/share_button.dart';
import '../../../services/constant.dart';
import '../../../cubit/home_cubit/home_cubit.dart';
import '../../../cubit/home_cubit/home_state.dart';
import '../../../model/app/hadeth_model.dart';
import '../../../widget/custom_appbar.dart';

class HadethList extends StatelessWidget with CustomsAppBar {
  final AlHadethModel dataOfHadeth;

  const HadethList({super.key, required this.dataOfHadeth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(
          context: context, title: dataOfHadeth.title, changeText: true),
      body: ListView.separated(
        padding: EdgeInsets.all(20.h),
        itemBuilder: (context, index) => Card(
          color: MyConstant.myWhite,
          elevation: 6,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(width: 0.1, color: MyConstant.primaryColor)),
          child: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Column(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Text(
                      dataOfHadeth.hadethItems[index],
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ShareButton(text: dataOfHadeth.hadethItems[index]),
                    CopyButton(
                        textCopy: dataOfHadeth.hadethItems[index],
                        textMessage: 'تم نسخ الذكر'),
                    CircleAvatar(
                        radius: 20.h,
                        backgroundColor: MyConstant.primaryColor,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(color: MyConstant.myWhite),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        itemCount: dataOfHadeth.hadethItems.length,
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
      ),
    );
  }
}
