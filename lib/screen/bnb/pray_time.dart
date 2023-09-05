import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../services/constant.dart';
import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../widget/pray_time_text.dart';
import '../../widget/qiblah/location_error_widget.dart';

class BNBarPrayTime extends StatefulWidget {
  const BNBarPrayTime({Key? key}) : super(key: key);

  @override
  State<BNBarPrayTime> createState() => _BNBarPrayTimeState();
}

class _BNBarPrayTimeState extends State<BNBarPrayTime> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    String arabicDay = DateFormat('EEEE', 'ar').format(DateTime.now());
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is ChangeCurrentPosition || cubit.currentPosition != null) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  child: Container(
                    padding: EdgeInsets.all(10.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyConstant.myWhite,
                      borderRadius: BorderRadius.circular(22.h),
                      border:
                          Border.all(color: MyConstant.primaryColor, width: 2),
                    ),
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
                                    cubit.prayerTimes!.nextPrayer().index][0]),
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
                                    .toString())
                      ],
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
        } else if (state is LoadingGetCurrentPosition) {
          return Center(
              child: CircularProgressIndicator(color: MyConstant.primaryColor));
        } else {
          return LocationErrorWidget(
              callback: () => cubit.getPosition(),
              error: "تم رفض إذن خدمة الموقع");
        }
      },
    );
  }
}
