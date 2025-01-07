import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/screen/bnb/home.dart';
import 'package:nahed_azkar/screen/bnb/pray_time.dart';
import 'package:nahed_azkar/screen/bnb/qiblah.dart';
import 'package:nahed_azkar/screen/bnb/settings.dart';
import 'package:nahed_azkar/utils/helpers.dart';

import '../../model/bnb.dart';
import '../../screen/bnb/qruan.dart';

import '../../storage/pref_controller.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with Helpers {
  HomeCubit() : super(HomeInitial());

  // screen list
  List<BNBar> listScreen = [
    BNBar(title: 'الرئيسية', body: const BNBarHome()),
    BNBar(title: 'مواقيت الصلاة', body: const BNBarPrayTime()),
    BNBar(title: 'القرآن الكريم', body: const BNBarQuran()),
    BNBar(title: 'القبلة', body: const BNBarQiblah()),
    BNBar(title: 'الإعدادات', body: BNBarSettings()),
  ];

  //controller of screen
  int currentIndex = 0;

  // change index controller
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(HomeChangeCurrentIndex());
  }

  //audio player
  final AudioPlayer player = AudioPlayer();
  bool isRadioRun = false;

  // radio  items
  Future<bool> runRadios({required String pathRadio}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    // stopRunQuranRecitersLoading();
    isRadioRun = true;
    runAudioOfAyaLoading();
    await player.play(UrlSource(pathRadio));
    emit(RunRadiosState());
    return true;
  }

  bool runQuranAudio = false;

  //
  void stopRunQuranRecitersLoading() async {
    isRadioRun = false;
    await player.stop();
    emit(RunQuranRecitersLoading());
  }

  Future<void> stopRadios() async {
    await player.stop();
    isRadioRun = false;
    emit(StopRadioState());
  }

  String initialRadioName = 'تلاوات خاشعة';
  String initialRadioPath = 'https://backup.qurango.net/radio/salma';
  int initialRadioIndex = 0;

  void changeRadioChannel(int index) {
    stopRadios();
    initialRadioIndex = index;
    initialRadioName = radiosChanel[index][0];
    initialRadioPath = radiosChanel[index][1];
    emit(ChangeRadioState());
  }

  //radio channel
  final List radiosChanel = [
    ["تلاوات خاشعة", 'https://backup.qurango.net/radio/salma'],
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

  // tasbih
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

  String selectItemTasbih = "سبحان الله و بحمده";
  int selectItemTasbihCount = 33;

  List tasbihItem = [
    ["سبحان الله و بحمده", 33],
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

  //change size of text
  double sizeText = 18.sp;

  void changeTextSize(value) {
    sizeText = value;
    emit(ChangeTextSize());
  }

  ThemeMode themeMode = ThemeMode.light;

  // change theme of application
  bool isDarkMode = false;

  void changeTheme(bool isDark) {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    if (themeMode == ThemeMode.dark) {
      MyConstant.kWhite = Colors.black;
      MyConstant.kBlack = Colors.white;
    } else {
      MyConstant.kWhite = Colors.white;
      MyConstant.kBlack = Colors.black;
    }
    isDarkMode = isDark;
    emit(ChangeTheme());
  }

  //change color app
  void changeAppColor(int color) {
    PrefController().changePrimaryColor(color);
    MyConstant.kPrimary = Color(color);
    emit(ChangeColorApp());
  }

  bool audioOfAyaLoading = false;

  void runAudioOfAyaLoading() {
    audioOfAyaLoading = true;
    emit(RunAudioOfAyaLoading());
  }
}
