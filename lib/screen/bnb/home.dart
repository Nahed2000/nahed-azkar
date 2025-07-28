import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/home_cubit/home_cubit.dart';
import 'package:nahed_azkar/utils/helpers.dart';

import '../../cubit/home_cubit/home_state.dart';
import '../../services/constant.dart';
import '../../data/home_data.dart';
import '../../widget/app/home/image_home.dart';
import '../../widget/app/home/radios_buttons.dart';

class BNBarHome extends StatelessWidget with Helpers {
  const BNBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ImageHome(),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: MyConstant.kPrimary,
                            blurRadius: 10,
                            spreadRadius: 0.1,
                            offset: const Offset(5, 0)),
                      ],
                      borderRadius: BorderRadius.circular(50.w),
                      color: MyConstant.kWhite,
                      border:
                          Border.all(color: MyConstant.kPrimary, width: 0.2)),
                  height: 140.h,
                  width: 450.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('إذاعة ${cubit.initialRadioName}',
                              style: TextStyle(
                                  fontFamily: 'ggess',
                                  color: MyConstant.kPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold)),
                          PopupMenuButton(
                            iconSize: 26.w,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(25.w),
                            ),
                            icon: Icon(Icons.list, color: MyConstant.kPrimary),
                            initialValue: cubit.initialRadioName,
                            itemBuilder: (context) => List.generate(
                              cubit.radiosChanel.length,
                              (index) => PopupMenuItem(
                                onTap: () => cubit.changeRadioChannel(index),
                                child: Text(
                                  cubit.radiosChanel[index][0],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RadiosButtons(
                              onPress: () async {
                                cubit.initialRadioIndex == 8
                                    ? cubit.changeRadioChannel(0)
                                    : cubit.changeRadioChannel(
                                        cubit.initialRadioIndex + 1);
                              },
                              icon: Icons.skip_next_rounded),
                          state is RunAudioOfAyaLoading
                              ? SizedBox(
                                  height: 30.w,
                                  child: CircularProgressIndicator(
                                      color: MyConstant.kPrimary),
                                )
                              : RadiosButtons(
                                  icon: cubit.isRadioRun
                                      ? Icons.pause_sharp
                                      : Icons.play_arrow,
                                  onPress: () async {
                                    if (cubit.isRadioRun) {
                                      cubit.stopRadios();
                                    } else {
                                      bool status = await cubit.runRadios(
                                          pathRadio: cubit.initialRadioPath);
                                      !status
                                          // ignore: use_build_context_synchronously
                                          ? showSnackBar(context,
                                              message:
                                                  'لا يوجد إتصال بالإنترنت',
                                              error: true)
                                          : null;
                                    }
                                  },
                                ),
                          RadiosButtons(
                              onPress: () {
                                cubit.initialRadioIndex == 0
                                    ? cubit.changeRadioChannel(8)
                                    : cubit.changeRadioChannel(
                                        cubit.initialRadioIndex - 1);
                              },
                              icon: Icons.skip_previous_rounded)
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: HomeData.homeCategories.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, HomeData.homeCategories[index].routName),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 8,
                      shadowColor: Colors.grey.shade100,
                      color: MyConstant.kWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide.none,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(HomeData.homeCategories[index].icon,
                                size: 40.h, color: MyConstant.kPrimary),
                            SizedBox(height: 5.h),
                            Text(
                              HomeData.homeCategories[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'ggess',
                                  fontSize: 12.sp,
                                  color: MyConstant.kPrimary,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
