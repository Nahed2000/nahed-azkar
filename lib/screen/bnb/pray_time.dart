import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nahed_azkar/cubit/location_cubit/location_cubit.dart';
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
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LocationCubit>(context);
    String arabicDay = DateFormat('EEEE', 'ar').format(DateTime.now());
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoadingState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: MyConstant.primaryColor),
                const SizedBox(height: 20),
                Text(
                  'انتظر لمدة ثواني عديدة فقط',
                  style:
                      TextStyle(fontSize: 20, color: MyConstant.primaryColor),
                )
              ],
            ),
          );
        } else if (cubit.myCoordinates != null) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  child: Card(
                    color: MyConstant.myWhite,
                    elevation: 6,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                            width: 0.1, color: MyConstant.primaryColor)),
                    child: Padding(
                      padding: EdgeInsets.all(20.0.w),
                      child: Column(
                        children: [
                          PrayTimeText(
                              firstText: arabicDay,
                              secondText:
                                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                          Divider(thickness: 2, color: MyConstant.primaryColor),
                          PrayTimeText(
                            firstText: 'الصلاةالقادمة',
                            secondText: cubit.prayerTimes!.nextPrayer().index -
                                        1 !=
                                    -1
                                ? cubit.prayerList![
                                        cubit.prayerTimes!.nextPrayer().index -
                                            1][0]
                                    .toString()
                                : cubit.prayerList![
                                    cubit.prayerTimes!.nextPrayer().index][0],
                          ),
                          Divider(thickness: 2, color: MyConstant.primaryColor),
                          PrayTimeText(
                            firstText: 'موعد الصلاة القادمة',
                            secondText: cubit.prayerTimes!.nextPrayer().index -
                                        1 !=
                                    -1
                                ? cubit.prayerList![
                                        cubit.prayerTimes!.nextPrayer().index -
                                            1][1]
                                    .toString()
                                : cubit.prayerList![cubit.prayerTimes!
                                        .nextPrayer()
                                        .index][1]
                                    .toString(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: PrayTimeText(
                        secondText: cubit.prayerList![index][1] ?? '',
                        firstText: cubit.prayerList![index][0] ?? ""),
                  ),
                  separatorBuilder: (context, index) => Divider(
                    color: MyConstant.primaryColor,
                    thickness: 1,
                  ),
                  itemCount: cubit.prayerList!.length,
                )
              ],
            ),
          );
        } else {
          return LocationErrorWidget(
              callback: () => cubit.getPosition(context),
              error: "تم رفض إذن خدمة الموقع");
        }
      },
    );
  }
}
