import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_cache_manager/media_cache_manager.dart';
import 'package:nahed_azkar/database/db_controller.dart';
import 'package:nahed_azkar/pref/pref_controller.dart';
import 'package:nahed_azkar/screen/notification_screen.dart';
import 'package:nahed_azkar/services/notification.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'cubit/home_cubit.dart';
import 'screen/app/al_ayat/ayat.dart';
import 'screen/app/al_azkar/azkar.dart';
import 'screen/app/al_hadeth/hadeth.dart';
import 'screen/app/name_of_allah.dart';
import 'screen/app/pray_of_mohammed.dart';
import 'screen/app/selat_rahem/selat_rahem.dart';
import 'screen/app/hijri.dart';
import 'screen/app/sonn_mahjora/sonn.dart';
import 'screen/app/story/story_categories.dart';
import 'screen/app/tasbih.dart';
import 'screen/bnb/home.dart';
import 'screen/home_screen.dart';
import 'screen/lunch.dart';

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//     NotificationService().sendNotificationToUser();
//     return Future.value(true);
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  tz.initializeTimeZones();
  await DbController().initDatabase();
  await MediaCacheManager.instance.init();
  NotificationService().initializeNotifications();
  // Workmanager().initialize(callbackDispatcher);
  // Workmanager().registerPeriodicTask(
  //   "uniqueTaskName", // اسم فريد للمهمة
  //   "simpleTask",
  //   initialDelay: const Duration(seconds: 5), // تأخير البدء بعد تسجيل المهمة
  //   frequency: const Duration(hours: 1), // تكرار كل ساعة
  // );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/lunch_screen',
            themeMode: BlocProvider.of<HomeCubit>(context).themeMode,
            routes: {
              '/lunch_screen': (context) => const LunchScreen(),
              '/bnbar_home_screen': (context) => const BNBarHome(),
              '/allah_name_screen': (context) => const NameOfAllahScreen(),
              '/tasbih_screen': (context) => const TasbihScreen(),
              '/azkar_screen': (context) => const AzkarScreen(),
              '/hadeth_screen': (context) => const AlHadethScreen(),
              '/hijri_screen': (context) => const HijriCalendarScreen(),
              '/home_app_screen': (context) => const HomeScreen(),
              '/story_screen': (context) => const StoryCategories(),
              '/sonn_screen': (context) => const SonnMahjoraScreen(),
              '/pray_of_mohammed_screen': (context) =>
                  const PrayOfMohammedScreen(),
              '/selat_rahem_screen': (context) => const SelatRahemScreen(),
              '/ayat_screen': (context) => const AyatScreen(),
              '/notification_screen': (context) => const NotificationScreen(),
            },
            locale: const Locale('ar'),
            supportedLocales: const [Locale('ar')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
