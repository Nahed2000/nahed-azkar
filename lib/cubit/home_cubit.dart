import 'package:adhan/adhan.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:nahed_azkar/database/controller/azkary_db_controller.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/pref/pref_controller.dart';
import 'package:nahed_azkar/screen/bnb/home.dart';
import 'package:nahed_azkar/screen/bnb/pray_time.dart';
import 'package:nahed_azkar/screen/bnb/qiblah.dart';
import 'package:nahed_azkar/screen/bnb/settings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/azkar/azkary.dart';
import '../model/bnb.dart';
import '../screen/bnb/qruan.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<BNBar> listScreen = [
    BNBar(title: 'الرئيسية', body: const BNBarHome()),
    BNBar(title: 'مواقيت الصلاة', body: const BNBarPrayTime()),
    BNBar(title: 'القرآن الكريم', body: const BNBarQuran()),
    BNBar(title: 'القبلة', body: const BNBarQiblah()),
    BNBar(title: 'الإعدادات', body: const BNBarSettings()),
  ];

  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(HomeChangeCurrentIndex());
  }

  Position? currentPosition;

  getPosition() async {
    emit(LoadingGetCurrentPosition());
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = await Geolocator.getCurrentPosition();
    changeMyCoordinates(
        Coordinates(currentPosition!.latitude, currentPosition!.longitude));
    emit(ChangeCurrentPosition());
    if (kDebugMode) {
      print('longitude = ${currentPosition!.longitude}');
      print('latitude = ${currentPosition!.latitude}');
    }
  }

  Coordinates? myCoordinates;

  void changeMyCoordinates(Coordinates currentCoordinates) {
    myCoordinates = currentCoordinates;
    changeCalculationParameters();
    emit(ChangeMyCoordinates());
  }

  CalculationParameters? calculationParameters;
  PrayerTimes? prayerTimes;

  void changeCalculationParameters() {
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;
    if (myCoordinates != null) {
      prayerTimes = PrayerTimes.today(myCoordinates!, params);
      changePrayerList();
    } else {
      getPosition();
    }
    emit(ChangeCalculationParameters());
  }

  List<List>? prayerList;

  void changePrayerList() {
    if (currentPosition != null) {
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

  void openWhatsAppChat(String phoneNo) {
    launchUrl(Uri.parse("whatsapp://send?phone=$phoneNo"));
  }

  void openGmailChat(String emailAddress) {
    final url = 'mailto:$emailAddress';
    launchUrl(Uri.parse(url));
  }

  void openTelegramChat(String username) async {
    final url = 'tg://t.me/$username';
    await launchUrl(Uri.parse(url));
  }

  void goToWebsite(String websiteUrl) async {
    launchUrl(Uri.parse(websiteUrl));
  }

  final AudioPlayer player = AudioPlayer();

  bool isRadioRun = false;

  void runRadios({required String pathRadio}) async {
    isRadioRun = true;
    await player.play(UrlSource(pathRadio));
    emit(RunRadiosState());
  }

  Future<void> stopRadios() async {
    await player.stop();
    isRadioRun = false;
    emit(StopRadioState());
  }

  String initialRadioName = 'القرآن الكريم';
  String initialRadioPath = 'https://backup.qurango.net/radio/salma';

  void changeRadioChannel(String name, String path) {
    stopRadios();
    initialRadioPath = path;
    initialRadioName = name;
    emit(ChangeRadioState());
  }

  List radiosChanel = [
    ["القرآن الكريم", 'https://backup.qurango.net/radio/salma'],
    ["الفتاوي", 'https://backup.qurango.net/radio/fatwa'],
    ["حياة الصحابة", 'https://backup.qurango.net/radio/sahabah'],
    ["تفسير القرآن", 'https://backup.qurango.net/radio/tafseer'],
    [
      "عبد الباسط عبد الصمد",
      'https://backup.qurango.net/radio/abdulbasit_abdulsamad_mojawwad'
    ],
    ["الرقية الشرعية", 'https://backup.qurango.net/radio/roqiah'],
    ["ماهر المعيلقي", 'https://backup.qurango.net/radio/maher'],
    [
      "المختصر في تفسير القرآن",
      "https://backup.qurango.net/radio/mukhtasartafsir"
    ],
    ["أحمد الحواشي", "https://backup.qurango.net/radio/ahmad_alhawashi"],
  ];

  bool isSound = true;
  int countTasbih = 0;
  int totalTasbih = 0;

  void changeCountTasbih() {
    if (isSound) {
      runAudio();
    }
    countTasbih++;
    totalTasbih++;
    emit(ChangeCountTasbih());
  }

  void restartCount() {
    countTasbih = 0;
    emit(RestartCountTasbih());
  }

  String selectItemTasbih = "سبحان الله و بجمده";
  int selectItemTasbihCount = 33;

  List tasbihItem = [
    ["سبحان الله و بجمده", 33],
    ["لا إله الإ الله", 100],
    ["الله أكبر", 33],
    ["الحمد لله", 33],
    ["إستغفر الله", 33],
    ["لا حول و إلا قوة الإ بالله", 100],
  ];

  void changeItemTasbih(String text, int number) {
    selectItemTasbih = text;
    selectItemTasbihCount = number;
    emit(ChangeItemTasbih());
  }

  void runAudio() {
    player.play(AssetSource('sound_button.mp3'));
  }

  void changeSound(bool isSound) {
    this.isSound = isSound;
    emit(ChangeSound());
  }

  double sizeText = 18.sp;

  void changeTextSize(value) {
    sizeText = value;
    emit(ChangeTextSize());
  }

  ThemeMode themeMode = ThemeMode.light;

  void changeTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    if (themeMode == ThemeMode.dark) {
      MyConstant.myWhite = Colors.black;
      MyConstant.myBlack = Colors.white;
    } else {
      MyConstant.myWhite = Colors.white;
      MyConstant.myBlack = Colors.black;
    }
    emit(ChangeTheme());
  }

  void changeAppColor(int color) {
    SharedPrefController().changePrimaryColor(color);
    MyConstant.primaryColor = Color(color);
    emit(ChangeColorApp());
  }

  List<UserAzkar> listAzkar = [];

  final AzkaryDbController _dbController = AzkaryDbController();

  void read() async {
    emit(LoadingAzkarState());
    listAzkar = await _dbController.read();
    emit(ReadAzkarState());
  }

  Future<bool> create({required UserAzkar userAzkar}) async {
    int newRowId = await _dbController.create(userAzkar);
    if (newRowId != 0) {
      userAzkar.id = newRowId;
      listAzkar.add(userAzkar);
      emit(CreateAzkarState());
    }
    return newRowId != 0;
  }

  Future<bool> delete(int index) async {
    bool deleted = await _dbController.delete(listAzkar[index].id);
    if (deleted) {
      listAzkar.removeAt(index);
      emit(DeleteAzkarState());
    }
    return deleted;
  }

  Future<bool> update({required UserAzkar userAzkar}) async {
    bool updated = await _dbController.update(userAzkar);
    if (updated) {
      int index = listAzkar.indexWhere((element) => element.id == userAzkar.id);
      if (index != 1) {
        listAzkar[index] = userAzkar;
        emit(UpdateAzkarState());
      }
    }
    return updated;
  }
}
