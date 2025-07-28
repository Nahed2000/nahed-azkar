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
        name: 'حاسبة الزكاة',
        icon: FlutterIslamicIcons.zakat,
        routName: '/zakat_screen'),
    HomeModel(
        name: 'التوقيت الهجري',
        icon: FlutterIslamicIcons.calendar,
        routName: '/hijri_screen'),
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
  ];
}
