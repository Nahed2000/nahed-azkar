
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../widget/qiblah/loading_indicator.dart';
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
    var cubit = BlocProvider.of<HomeCubit>(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is LoadingGetCurrentPosition &&
              cubit.currentPosition != null) {
            return const LoadingIndicator();
          }
          if (cubit.currentPosition != null) {
            return QiblahCompassWidget();
          } else {
            return LocationErrorWidget(
              error: 'تم رفض إذن خدمة الموقع',
              callback: () => cubit.getPosition(),
            );
          }
        },
      ),
    );
  }
//
// Future<void> _checkLocationStatus() async {
//   final locationStatus = await FlutterQiblah.checkLocationStatus();
//   if (locationStatus.enabled &&
//       locationStatus.status == LocationPermission.denied) {
//     await FlutterQiblah.requestPermissions();
//     final s = await FlutterQiblah.checkLocationStatus();
//     _locationStreamController.sink.add(s);
//   } else {
//     _locationStreamController.sink.add(locationStatus);
//   }
// }}
}
