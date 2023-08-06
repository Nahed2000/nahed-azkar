import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

import '../model/home_model.dart';

class HomeData {
  static List<HomeModel> homeCategories = [
    HomeModel(
        name: 'الأذكار',
        icon: FlutterIslamicIcons.prayer,
        routName: '/azkar_screen'),
    HomeModel(
        name: 'المسبحة',
        icon: FlutterIslamicIcons.tasbih2,
        routName: '/tasbih_screen'),
    HomeModel(
        name: 'أسماء الله',
        icon: FlutterIslamicIcons.allah99,
        routName: '/allah_name_screen'),
    HomeModel(
        name: 'أحاديث نبوية',
        icon: FlutterIslamicIcons.mohammad,
        routName: '/hadeth_screen'),
    HomeModel(
        name: 'آيات من القرآن',
        icon: FlutterIslamicIcons.quran,
        routName: '/ayat_screen'),
    HomeModel(
        name: 'سنن مهجورة',
        icon: FlutterIslamicIcons.prayingPerson,
        routName: '/sonn_screen'),
    HomeModel(
        name: 'قصص مختصرة',
        icon: FlutterIslamicIcons.tawhid,
        routName: '/story_screen'),
    HomeModel(
        name: 'صلاوات',
        icon: FlutterIslamicIcons.solidMohammad,
        routName: '/pray_of_mohammed_screen'),
    HomeModel(
        name: 'صلة الرحم',
        icon: FlutterIslamicIcons.family,
        routName: '/selat_rahem_screen'),
  ];
}
