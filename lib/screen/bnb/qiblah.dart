import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/prayer_time_cubit/pray_time_cubit.dart';
import 'package:nahed_azkar/cubit/prayer_time_cubit/pray_time_state.dart';

import '../../services/constant.dart';
import '../../widget/qiblah/location_error_widget.dart';
import '../../widget/qiblah/qiblah_compass_widget.dart';

class BNBarQiblah extends StatefulWidget {
  const BNBarQiblah({super.key});

  @override
  BNBarQiblahState createState() => BNBarQiblahState();
}

class BNBarQiblahState extends State<BNBarQiblah> {
  @override
  void dispose() {
    FlutterQiblah().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<PrayerTimeCubit>(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
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
                          fontSize: 14.sp,
                          color: MyConstant.kPrimary))
                ],
              ),
            );
          }
          if (cubit.currentPosition != null || cubit.myCoordinates != null) {
            return QiblahCompassWidget();
          } else {
            return LocationErrorWidget(
              error: 'تم رفض إذن خدمة الموقع',
              callback: () => cubit.getUserLocation(context),
            );
          }
        },
      ),
    );
  }
}
