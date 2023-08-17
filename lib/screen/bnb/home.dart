import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/home_cubit.dart';
import 'package:nahed_azkar/cubit/home_state.dart';
import 'package:nahed_azkar/services/notification.dart';
import 'package:nahed_azkar/utils/helpers.dart';

import '../../services/constant.dart';
import '../../data/home_data.dart';
import '../../widget/radios_buttons.dart';

class BNBarHome extends StatelessWidget with Helpers {
  const BNBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200.h,
                alignment: Alignment.center,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                  image: DecorationImage(
                    image: const AssetImage(
                      'assets/images/mo1.jpg',
                    ),
                    colorFilter: ColorFilter.mode(
                        MyConstant.primaryColor, BlendMode.color),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.h)),
                    child: Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: Text('سَبِّحِ ٱسۡمَ رَبِّكَ ٱلۡأَعۡلَى',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold))))),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) => Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.w),
                    color: MyConstant.myWhite,
                    border:
                        Border.all(color: MyConstant.primaryColor, width: 2)),
                height: 100.h,
                child: Column(
                  children: [
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Text('إذاعة ${cubit.initialRadioName}',
                              style: TextStyle(
                                  color: MyConstant.primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          PopupMenuButton(
                              iconSize: 26.w,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.w)),
                              icon: Icon(Icons.list,
                                  color: MyConstant.primaryColor),
                              initialValue: cubit.initialRadioName,
                              itemBuilder: (context) => List.generate(
                                  cubit.radiosChanel.length,
                                  (index) => PopupMenuItem(
                                      onTap: () => cubit.changeRadioChannel(
                                          cubit.radiosChanel[index][0],
                                          cubit.radiosChanel[index][1]),
                                      child:
                                          Text(cubit.radiosChanel[index][0]))))
                        ])),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          RadiosButtons(
                              onPress: () async {},
                              icon: Icons.skip_next_rounded),
                          state is RunAudioOfAyaLoading
                              ? SizedBox(
                                  height: 20.w,
                                  child: CircularProgressIndicator(
                                    color: MyConstant.primaryColor,
                                  ),
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
                                              massage:
                                                  'لا يوجد إتصال بالإنترنت',
                                              error: true)
                                          : null;
                                    }
                                  },
                                ),
                          RadiosButtons(
                              onPress: () {
                                NotificationService().sendNotificationToUser();
                              },
                              icon: Icons.skip_previous_rounded)
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
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
                  elevation: 4,
                  color: MyConstant.myWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: MyConstant.primaryColor),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          HomeData.homeCategories[index].icon,
                          size: 40.h,
                          color: MyConstant.primaryColor,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          HomeData.homeCategories[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: MyConstant.primaryColor,
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
      ),
    );
  }
}
