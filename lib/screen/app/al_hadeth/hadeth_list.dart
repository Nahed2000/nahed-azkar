import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widget/app/copy_button.dart';
import '../../../../widget/app/share_button.dart';
import '../../../services/constant.dart';
import '../../../cubit/home_cubit.dart';
import '../../../cubit/home_state.dart';
import '../../../model/app/hadeth_model.dart';
import '../../../widget/custom_appbar.dart';

class HadethList extends StatelessWidget {
  final AlHadethModel dataOfHadeth;

  const HadethList({super.key, required this.dataOfHadeth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, dataOfHadeth.title,
          bnbar: false, changeText: true),
      body: ListView.separated(
        padding: EdgeInsets.all(20.h),
        itemBuilder: (context, index) =>
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                  color: MyConstant.myWhite,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(width: 1, color: MyConstant.primaryColor)),
              child: Column(
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Text(
                        dataOfHadeth.hadethItems[index],
                        style: TextStyle(
                          fontSize: BlocProvider
                              .of<HomeCubit>(context)
                              .sizeText,
                          color: MyConstant.myBlack,
                        ),
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
        itemCount: dataOfHadeth.hadethItems.length,
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
      ),
    );
  }
}
