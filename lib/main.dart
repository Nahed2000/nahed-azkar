import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_cache_manager/media_cache_manager.dart';
import 'package:nahed_azkar/cubit/db_aya_cubit/db_aya_cubit.dart';
import 'package:nahed_azkar/cubit/db_azkar_cubit/db_azkar_cubit.dart';
import 'package:nahed_azkar/cubit/prayer_time_cubit/pray_time_cubit.dart';
import 'package:nahed_azkar/cubit/notification_cubit/notification_cubit.dart';
import 'package:nahed_azkar/db/db_controller.dart';
import 'package:nahed_azkar/storage/pref_controller.dart';
import 'package:nahed_azkar/screen/settings/notification_screen.dart';
import 'package:nahed_azkar/services/notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'cubit/home_cubit/home_cubit.dart';
import 'screen/home/al_ayat/ayat.dart';
import 'screen/home/al_azkar/azkar.dart';
import 'screen/home/al_hadeth/hadeth.dart';
import 'screen/home/name_of_allah.dart';
import 'screen/home/pray_of_mohammed.dart';
import 'screen/home/selat_rahem/selat_rahem.dart';
import 'screen/settings/hijri.dart';
import 'screen/home/sonn_mahjora/sonn.dart';
import 'screen/home/story/story_categories.dart';
import 'screen/home/tasbih.dart';
import 'screen/settings/aya_saved_screen.dart';
import 'screen/bnb/home.dart';
import 'screen/home_screen.dart';
import 'screen/launch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefController().initPref();
  tz.initializeTimeZones();
  await MediaCacheManager.instance.init();
  await DbController().initDatabase();
  await NotificationService().initializeNotifications();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Workmanager().initialize(callbackDispatcher);
  // Workmanager().registerPeriodicTask(
  //   "uniqueTaskName",
  //   "simpleTask",
  //   initialDelay: const Duration(seconds: 5),
  //   frequency: const Duration(minutes: 15),
  // );
  runApp(const HomeApp());
}

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     await PrefController().initPref();
//     await NotificationService().sendNotificationWithoutPrefController();
//     return Future.value(true);
//   });
// }

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<DbAzkarCubit>(create: (context) => DbAzkarCubit()),
        BlocProvider<DbAyaCubit>(create: (context) => DbAyaCubit()),
        BlocProvider<NotificationCubit>(
            create: (context) => NotificationCubit()),
        BlocProvider<PrayerTimeCubit>(create: (context) => PrayerTimeCubit()),
      ],
      child: const MyMaterial(),
    );
  }
}

class MyMaterial extends StatelessWidget {
  const MyMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/launch_screen',
          themeMode: BlocProvider.of<HomeCubit>(context).themeMode,
          routes: {
            '/launch_screen': (context) => const LunchScreen(),
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
            '/aya_saved_screen': (context) => const AyaSavedScreen(),
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
    );
  }
}
