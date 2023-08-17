import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_cache_manager/media_cache_manager.dart';
import 'package:nahed_azkar/database/db_controller.dart';
import 'package:nahed_azkar/pref/pref_controller.dart';
import 'package:nahed_azkar/services/notification.dart';
import 'package:workmanager/workmanager.dart';
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

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    NotificationService().sendNotificationToUser();
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationService().initializeNotifications();
  // NotificationService().alKahafNotification();
  tz.initializeTimeZones();
  await SharedPrefController().initPref();
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    "uniqueTaskName", // اسم فريد للمهمة
    "simpleTask",
    initialDelay: const Duration(seconds: 5), // تأخير البدء بعد تسجيل المهمة
    frequency: const Duration(milliseconds: 900000), // تكرار كل ساعة
  );
  await DbController().initDatabase();
  await MediaCacheManager.instance.init();
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

// }
// // import 'package:flutter/material.dart';
// // import 'package:nahed_azkar/services/notification.dart';
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   final NotificationService notificationService = NotificationService();
// //   await notificationService.initialize();
// //
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     // عرض الإشعار عند فتح التطبيق
// //     NotificationService().showNotification();
// //
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('MyApp'),
// //         ),
// //         body: const Center(
// //           child: Text('Welcome to MyApp'),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
//
//
// //
// //     endTime = DateTime.now().add(Duration(hours: 1)); // تحديد وقت النهاية بعد ساعة من الوقت الحالي
// //     countdownStream = Stream.periodic(Duration(seconds: 1), (int count) {
// //       Duration remainingTime = endTime!.difference(DateTime.now());
// //       return remainingTime.inSeconds;
// //
// //     countdownSubscription = countdownStream.listen((seconds) {
// //       setState(() {
// //         remainingSeconds = seconds;
// //       });
// //
// //       if (remainingSeconds <= 0) {
// //         countdownSubscription.cancel();
// //       }
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     countdownSubscription.cancel();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     int hours = remainingSeconds ~/ 3600;
// //     int minutes = (remainingSeconds % 3600) ~/ 60;
// //     int seconds = remainingSeconds % 60;
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Countdown Timer'),
// //       ),
// //       body: Center(
// //         child: Text(
// //           '$hours:$minutes:$seconds',
// //           style: TextStyle(fontSize: 24),
// //         ),
// //       ),
// //     );
// //   }
// // }
