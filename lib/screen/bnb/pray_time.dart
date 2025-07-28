import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nahed_azkar/cubit/home_cubit/home_cubit.dart';
import 'package:nahed_azkar/cubit/home_cubit/home_state.dart';
import 'package:nahed_azkar/cubit/prayer_time_cubit/pray_time_cubit.dart';
import 'package:nahed_azkar/cubit/prayer_time_cubit/pray_time_state.dart';
import 'package:nahed_azkar/storage/pref_controller.dart';

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
    // TODO: implement initState
    PrefController().latitude != null
        ? BlocProvider.of<PrayerTimeCubit>(context).startTimer()
        : null;
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    PrefController().latitude != null
        ? BlocProvider.of<PrayerTimeCubit>(context).stopTimer()
        : null;
    super.deactivate();
  }

  String arabicDay = DateFormat('EEEE', 'ar').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<PrayerTimeCubit>(context);
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
                            color: MyConstant.kPrimary)),
                  ],
                ),
              );
            } else if (cubit.myCoordinates != null) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsetsDirectional.all(10),
                children: [
                  Card(
                    color: MyConstant.kWhite,
                    elevation: 8,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      // side:
                      //     BorderSide(width: 0.1, color: MyConstant.kPrimary)),
                    ),
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
                            firstText: 'الوقت',
                            secondText: cubit.getDateTimeNextPrayer(),
                            isShowTimer: true,
                            time: cubit.isStartTimer
                                ? cubit.getStillTextTime()
                                : 'انتهى اليوم',
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Card(
                      color: MyConstant.kWhite,
                      elevation: 8,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Icon(FlutterIslamicIcons.prayingPerson,
                            size: 32, color: MyConstant.kPrimary),
                        title: Text(
                          cubit.prayerList![index].title,
                          style: TextStyle(
                            color: MyConstant.kPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          cubit.prayerList![index].dateTime,
                          style: TextStyle(
                            color: MyConstant.kPrimary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    itemCount: cubit.prayerList!.length,
                  )
                ],
              );
            } else {
              return LocationErrorWidget(
                  callback: () => cubit.getUserLocation(context),
                  error: "تم رفض إذن خدمة الموقع");
            }
          },
        );
      },
    );
  }
}
