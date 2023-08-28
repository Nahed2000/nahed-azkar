import 'dart:async';
import 'dart:convert';

import 'package:adhan/adhan.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:nahed_azkar/cubit/api_response.dart';
import 'package:nahed_azkar/database/controller/azkary_db_controller.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/pref/pref_controller.dart';
import 'package:nahed_azkar/screen/bnb/home.dart';
import 'package:nahed_azkar/screen/bnb/pray_time.dart';
import 'package:nahed_azkar/screen/bnb/qiblah.dart';
import 'package:nahed_azkar/screen/bnb/settings.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/azkar/azkary.dart';
import '../model/bnb.dart';
import '../screen/bnb/qruan.dart';
import 'home_state.dart';

import 'package:http/http.dart' as http;

class HomeCubit extends Cubit<HomeState> with Helpers {
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

  void openInstagramChatInBrowser(String username) async {
    final url = 'https://www.instagram.com/direct/t/?username=$username';
    await launchUrl(Uri.parse(url));
  }

  final AudioPlayer player = AudioPlayer();

  bool isRadioRun = false;

  Future<bool> runRadios({required String pathRadio}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    isRadioRun = true;
    runAudioOfAyaLoading();
    await player.play(UrlSource(pathRadio));
    emit(RunRadiosState());
    return true;
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

  void getSearchOfAya({required String searchText}) async {
    String uri =
        'https://api-quran.cf/quransql/index.php?type=search&text=$searchText';
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List listResult = jsonResponse['result'];
      emit(GetSearchOfAya(result: listResult));
    } else {
      emit(GetSearchOfAya(result: ['الرجاء تشغيل الإنترنت']));
    }
  }

  bool audioOfAyaLoading = false;

  void runAudioOfAyaLoading() {
    audioOfAyaLoading = true;
    emit(RunAudioOfAyaLoading());
  }

  Future<bool> getAudioOfAya(
      {required int suraNumber, required int ayaNumber}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // لا يوجد اتصال بالإنترنت
      return false;
    }
    runAudioOfAyaLoading();
    String getSura() {
      if (suraNumber <= 9) {
        return '00$suraNumber';
      } else if (suraNumber >= 9 && suraNumber <= 99) {
        return '0$suraNumber';
      } else {
        return '$suraNumber';
      }
    }

    String getAya() {
      if (ayaNumber <= 9) {
        return '00$ayaNumber';
      } else if (ayaNumber >= 9 && ayaNumber <= 99) {
        return '0$ayaNumber';
      } else {
        return '$ayaNumber';
      }
    }

    await player.play(UrlSource(
        'https://a.equran.me/Ahmed-Alajamy/${getSura()}${getAya()}.mp3'));
    audioOfAyaLoading = false;
    emit(GetAudioOfAya());
    return true;
  }

  int ayaIndex = 0;

  void changeAyaIndex(int index) {
    ayaIndex = index;
    emit(ChangeAyaIndex());
  }

  Future<ApiResponse> getTafsir(
      {required String aya, required String sura}) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return ApiResponse(message: 'لا يوجد اتصال بالإنترنت', status: false);
      }

      Uri url = Uri.parse('http://api.quran-tafseer.com/tafseer/1/$sura/$aya');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return ApiResponse(message: jsonResponse['text'], status: true);
      } else {
        return ApiResponse(
            message: 'خطأ أثناء استرداد البيانات', status: false);
      }
    } catch (e) {
      return ApiResponse(message: 'حدث خطأ غير متوقع', status: false);
    }
  }

  bool changeAllNotificationItem = SharedPrefController().allNotificationItem;

  bool hourlyNotificationItem = SharedPrefController().hourlyNotificationItem;

  bool alkahefNotificationItem = SharedPrefController().alkahefNotificationItem;

  bool quranNotificationItem = SharedPrefController().quranNotificationItem;

  bool prayOfMohammedNotificationItem =
      SharedPrefController().prayOfMohammedNotification;

  bool morningNotificationItem = SharedPrefController().morningNotificationItem;

  bool eveningNotificationItem = SharedPrefController().eveningNotificationItem;

  void changeAllNotification(bool value) async {
    await SharedPrefController().changeAllNotification(value);
    await SharedPrefController().changeHourlyNotificationItem(value);
    await SharedPrefController().changeAkahefNotificationItem(value);
    await SharedPrefController().changeQuranNotificationItem(value);
    await SharedPrefController().changePrayOfMohammedNotification(value);
    await SharedPrefController().changeMorningNotificationItem(value);
    await SharedPrefController().changeEveningNotificationItem(value);
    changeAllNotificationItem = value;
    hourlyNotificationItem = value;
    alkahefNotificationItem = value;
    quranNotificationItem = value;
    prayOfMohammedNotificationItem = value;
    morningNotificationItem = value;
    eveningNotificationItem = value;
    emit(ChangeAllNotification());
  }

  void hourlyNotification(bool value) {
    SharedPrefController().changeHourlyNotificationItem(value);
    hourlyNotificationItem = value;
    emit(ChangeAllNotification());
  }

  void alkahefNotification(bool value) {
    SharedPrefController().changeAkahefNotificationItem(value);
    alkahefNotificationItem = value;
    emit(ChangeAllNotification());
  }

  void quranNotification(bool value) {
    SharedPrefController().changeQuranNotificationItem(value);
    quranNotificationItem = value;
    emit(ChangeAllNotification());
  }

  void prayOfMohammedNotification(bool value) {
    SharedPrefController().changePrayOfMohammedNotification(value);
    prayOfMohammedNotificationItem = value;
    emit(ChangeAllNotification());
  }

  void morningNotification(bool value) {
    SharedPrefController().changeMorningNotificationItem(value);
    morningNotificationItem = value;
    emit(ChangeAllNotification());
  }

  void eveningNotification(bool value) {
    SharedPrefController().changeEveningNotificationItem(value);
    eveningNotificationItem = value;
    emit(ChangeAllNotification());
  }
}
