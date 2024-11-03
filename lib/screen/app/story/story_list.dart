import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubit/home_cubit/home_cubit.dart';
import '../../../cubit/home_cubit/home_state.dart';
import '../../../services/constant.dart';
import '../../../widget/custom_appbar.dart';

class StoryList extends StatelessWidget with CustomsAppBar {
  final List items;

  const StoryList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context: context, title: items[0], changeText: true),
      body: ListView(
        padding: EdgeInsets.all(20.h),
        children: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Text(
                items[1],
                style: TextStyle(
                    color: MyConstant.myBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: BlocProvider.of<HomeCubit>(context).sizeText),
                textAlign: TextAlign.justify,
              );
            },
          ),
        ],
      ),
    );
  }
}
