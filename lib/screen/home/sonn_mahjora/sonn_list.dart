import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cubit/home_cubit/home_state.dart';
import '../../../model/app/sonn.dart';
import '../../../services/constant.dart';
import '../../../cubit/home_cubit/home_cubit.dart';
import '../../../widget/custom_appbar.dart';

class SonnListScreen extends StatelessWidget with CustomsAppBar {
  const SonnListScreen({Key? key, required this.sonnModel}) : super(key: key);
  final SonnModel sonnModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: customAppBar(
          context: context, title: sonnModel.title, changeText: true),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.all(20.h),
            children: [
              Text(
                sonnModel.description,
                style: TextStyle(fontFamily: 'ggess',
                    color: MyConstant.kBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: BlocProvider.of<HomeCubit>(context).sizeText),
                textAlign: TextAlign.justify,
              ),
            ],
          );
        },
      ),
    );
  }
}
