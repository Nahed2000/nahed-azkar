import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nahed_azkar/cubit/home_cubit/home_cubit.dart';
import 'package:nahed_azkar/cubit/home_cubit/home_state.dart';
import 'package:nahed_azkar/cubit/location_cubit/prayer_time_cubit.dart';
import 'package:nahed_azkar/cubit/location_cubit/location_state.dart';

import '../../services/constant.dart';

import '../../widget/app/pray_time_text.dart';
import '../../widget/qiblah/location_error_widget.dart';

class BNBarPrayTime extends StatefulWidget {
  const BNBarPrayTime({Key? key}) : super(key: key);

  @override
  State<BNBarPrayTime> createState() => _BNBarPrayTimeState();
}

class _BNBarPrayTimeState extends State<BNBarPrayTime> {
  @override
  void initState() {
    BlocProvider.of<PrayerTimeCubit>(context).startTimer();
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    BlocProvider.of<PrayerTimeCubit>(context).stopTimer();

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<PrayerTimeCubit>(context);
    //TODO//////////////////////////////// THIS SHOULD
    print(cubit.getDifferanceTimeNextPrayer(cubit.getDateTimeNextPrayer()));
    String arabicDay = DateFormat('EEEE', 'ar').format(DateTime.now());
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
          builder: (context, state) {
            if (state is PrayerTimeLoadingState) {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    CircularProgressIndicator(color: MyConstant.kPrimary),
                    const SizedBox(height: 20),
                    Text('انتظر لمدة ثواني عديدة فقط',
                        style: TextStyle(
                            fontFamily: 'ggess',
                            fontSize: 20,
                            color: MyConstant.kPrimary))
                  ]));
            } else if (cubit.myCoordinates != null) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsetsDirectional.all(10),
                children: [
                  Card(
                    color: MyConstant.kWhite,
                    elevation: 6,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side:
                            BorderSide(width: 0.1, color: MyConstant.kPrimary)),
                    child: Padding(
                      padding: EdgeInsets.all(20.0.w),
                      child: Column(
                        children: [
                          PrayTimeText(
                              firstText: arabicDay,
                              secondText: cubit.getDateNow()),
                          Divider(thickness: 2, color: MyConstant.kPrimary),
                          PrayTimeText(
                              firstText: 'الصلاة القادمة',
                              secondText: cubit.getNameNextPrayer()),
                          Divider(thickness: 2, color: MyConstant.kPrimary),
                          PrayTimeText(
                              firstText: 'موعد الصلاة القادمة',
                              secondText: cubit.getDateTimeNextPrayer())
                        ],
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: PrayTimeText(
                        secondText: cubit.prayerList![index].dateTime,
                        firstText: cubit.prayerList![index].title,
                        isShowTimer: cubit.prayerList![index].dateTime ==
                            cubit.getDateTimeNextPrayer(),
                        time: cubit.seconds,
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        Divider(color: MyConstant.kPrimary, thickness: 1),
                    itemCount: cubit.prayerList!.length,
                  )
                ],
              );
            } else {
              return LocationErrorWidget(
                  callback: () => cubit.getPosition(context),
                  error: "تم رفض إذن خدمة الموقع");
            }
          },
        );
      },
    );
  }
}
