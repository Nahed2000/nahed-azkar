import 'package:adhan/adhan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:nahed_azkar/cubit/location_cubit/location_state.dart';
import 'package:nahed_azkar/storage/pref_controller.dart';
import 'package:nahed_azkar/utils/helpers.dart';

class LocationCubit extends Cubit<LocationState> with Helpers {
  LocationCubit() : super(LocationInitialState());

  bool loading = false;

  Position? currentPosition;

  void getPosition(BuildContext context) async {
    SharedPrefController().clear();
    loading = true;
    emit(LocationLoadingState());
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(context,
          message: ' يرجى تشغيل خدمة الموقع للتحديث', error: true);
      emit(FailedLocationState());
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(context,
            message: 'لم يتم اعطاء صلاحية الموقع', error: true);
        emit(FailedLocationState());
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(context,
          message: 'لم يتم اعطاء صلاحية الموقع, يرجى تفعيلها من الاعدادات ',
          error: true);
      emit(FailedLocationState());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = await Geolocator.getCurrentPosition();
    if (currentPosition != null) {
      SharedPrefController().clear();
      if (kDebugMode) {
        print('longitude = ${currentPosition!.longitude}');
        print('latitude = ${currentPosition!.latitude}');
      }
      SharedPrefController().saveUserLocation(
        latitude: currentPosition!.latitude,
        longitude: currentPosition!.longitude,
      );
      changeMyCoordinates(
          Coordinates(currentPosition!.latitude, currentPosition!.longitude),
          context);
      emit(SuccessfullyGetLocationState());
    }
    loading = false;
    emit(SuccessfullyGetLocationState());
  }

  Coordinates? myCoordinates;

  // change prayer time
  void changeCalculationParameters(BuildContext context) async {
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    if (myCoordinates != null) {
      prayerTimes = PrayerTimes.today(myCoordinates!, params);
      changePrayerList();
    } else {
      getPosition(context);
    }
    emit(ChangeCalculationParameters());
  }

  void changeMyCoordinates(
      Coordinates currentCoordinates, BuildContext context) {
    myCoordinates = currentCoordinates;
    changeCalculationParameters(context);
    emit(ChangeMyCoordinates());
  }

  //
  PrayerTimes? prayerTimes;

  List<List>? prayerList;

  // prayer list
  void changePrayerList() {
    if (currentPosition != null || myCoordinates != null) {
      prayerList = [
        ['صلاة الفجر', DateFormat.jm().format(prayerTimes!.fajr)],
        ['شروق الشمس', DateFormat.jm().format(prayerTimes!.sunrise)],
        ['صلاة الظهر', DateFormat.jm().format(prayerTimes!.dhuhr)],
        ['صلاة العصر', DateFormat.jm().format(prayerTimes!.asr)],
        ['صلاة المغرب', DateFormat.jm().format(prayerTimes!.maghrib)],
        ['صلاة العشاء', DateFormat.jm().format(prayerTimes!.isha)],
      ];
      emit(ChangePrayerList());
    } else {
      prayerList = [];
      emit(EmptyPryerList());
    }
  }
}
