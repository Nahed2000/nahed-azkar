import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:nahed_azkar/cubit/prayer_time_cubit/pray_time_state.dart';
import 'package:nahed_azkar/model/prayer_time_model.dart';
import 'package:nahed_azkar/storage/pref_controller.dart';
import 'package:nahed_azkar/utils/helpers.dart';

class PrayerTimeCubit extends Cubit<PrayerTimeState> with Helpers {
  PrayerTimeCubit() : super(PrayerTimeInitialState());

  bool loading = false;

  Position? currentPosition;

  void getUserLocation(BuildContext context) async {
    PrefController().clear();
    loading = true;
    emit(PrayerTimeLoadingState());
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(
          // ignore: use_build_context_synchronously
          context,
          message: ' يرجى تشغيل خدمة الموقع للتحديث',
          error: true);
      emit(FailedPrayerTimeState());
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        showSnackBar(context,
            message: 'لم يتم اعطاء صلاحية الموقع', error: true);
        emit(FailedPrayerTimeState());
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(
          // ignore: use_build_context_synchronously
          context,
          message: 'لم يتم اعطاء صلاحية الموقع, يرجى تفعيلها من الاعدادات ',
          error: true);
      emit(FailedPrayerTimeState());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = await Geolocator.getCurrentPosition();
    if (currentPosition != null) {
      PrefController().clear();
      if (kDebugMode) {
        print('longitude = ${currentPosition!.longitude}');
        print('latitude = ${currentPosition!.latitude}');
      }
      PrefController().saveUserLocation(
        latitude: currentPosition!.latitude,
        longitude: currentPosition!.longitude,
      );
      changeMyCoordinates(
          Coordinates(currentPosition!.latitude, currentPosition!.longitude),
          // ignore: use_build_context_synchronously
          context);
      stopTimer();
      startTimer();
      emit(SuccessfullyGetPrayerTimeState());
    }
    loading = false;
    emit(SuccessfullyGetPrayerTimeState());
  }

  Coordinates? myCoordinates;

  void changeCalculationParameters(BuildContext context) async {
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    if (myCoordinates != null) {
      prayerTimes = PrayerTimes.today(myCoordinates!, params);
      changePrayerList();
    } else {
      getUserLocation(context);
    }
    emit(ChangeCalculationParameters());
  }

  void changeMyCoordinates(
      Coordinates currentCoordinates, BuildContext context) {
    myCoordinates = currentCoordinates;
    changeCalculationParameters(context);
    emit(ChangeMyCoordinates());
  }

  PrayerTimes? prayerTimes;

  List<PrayerTimeModel>? prayerList;

  void changePrayerList() {
    if (currentPosition != null || myCoordinates != null) {
      prayerList = [
        PrayerTimeModel(
            title: 'صلاة الفجر',
            dateTime: DateFormat.jm().format(prayerTimes!.fajr)),
        PrayerTimeModel(
            title: 'شروق الشمس',
            dateTime: DateFormat.jm().format(prayerTimes!.sunrise)),
        PrayerTimeModel(
            title: 'صلاة الظهر',
            dateTime: DateFormat.jm().format(prayerTimes!.dhuhr)),
        PrayerTimeModel(
            title: 'صلاة العصر',
            dateTime: DateFormat.jm().format(prayerTimes!.asr)),
        PrayerTimeModel(
            title: 'صلاة المغرب',
            dateTime: DateFormat.jm().format(prayerTimes!.maghrib)),
        PrayerTimeModel(
            title: 'صلاة العشاء',
            dateTime: DateFormat.jm().format(prayerTimes!.isha)),
      ];
      emit(ChangePrayerList());
    } else {
      prayerList = [];
      emit(EmptyPryerList());
    }
  }

  String getDateNow() =>
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

  String getDateTimeNextPrayer() {
    return prayerTimes!.nextPrayer().index - 1 != -1
        ? prayerList![prayerTimes!.nextPrayer().index - 1].dateTime
        : prayerList![prayerTimes!.nextPrayer().index].dateTime;
  }

  String getNameNextPrayer() {
    return prayerTimes!.nextPrayer().index - 1 != -1
        ? prayerList![prayerTimes!.nextPrayer().index - 1].title.toString()
        : prayerList![prayerTimes!.nextPrayer().index].title;
  }

  Duration timeLeft = const Duration(seconds: 5);

  void getDifferanceTimeNextPrayer() {
    DateFormat format = DateFormat.jm();
    DateTime specificDateTime = format.parse(getDateTimeNextPrayer());
    specificDateTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, specificDateTime.hour, specificDateTime.minute);
    Duration difference = specificDateTime.difference(DateTime.now());
    if (specificDateTime.isBefore(DateTime.now())) {
      specificDateTime = specificDateTime.add(const Duration(days: 1));
    }
    timeLeft = difference;
  }

  late Timer timer;

  void startTimer() {
    getDifferanceTimeNextPrayer();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.inSeconds > 0) {
        timeLeft = timeLeft - const Duration(seconds: 1);
        emit(StartTimerPrayerTimeState());
      } else {
        getDifferanceTimeNextPrayer();
        emit(StopPrayerTimeState());
      }
    });
  }

  void stopTimer() {
    timer.cancel();
    emit(StopPrayerTimeState());
  }

  String getStillTextTime() {
    int hours = timeLeft.inHours;
    int minutes = (timeLeft.inMinutes % 60);
    int seconds = (timeLeft.inSeconds % 60);
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
