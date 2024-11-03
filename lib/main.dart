import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/db_cubit/db_cubit.dart';
import 'package:nahed_azkar/cubit/location_cubit/location_cubit.dart';
import 'package:nahed_azkar/cubit/notification_cubit/notification_cubit.dart';
import 'package:nahed_azkar/db/db_controller.dart';
import 'package:nahed_azkar/storage/pref_controller.dart';
import 'package:nahed_azkar/screen/notification_screen.dart';
import 'package:nahed_azkar/services/notification.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

import 'cubit/home_cubit/home_cubit.dart';
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
import 'screen/launch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await DbController().initDatabase();
  await SharedPrefController().initPref();
  await NotificationService().initializeNotifications();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Workmanager().initialize(callbackDispatcher);

  Workmanager().registerPeriodicTask(
    "uniqueTaskName",
    "simpleTask",
    initialDelay: const Duration(seconds: 5), // تأخير البدء
    frequency:
        const Duration(minutes: 15), // تكرار كل 15 دقيقة (أو أي فترة تريدها)
  );
  runApp(const HomeApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    NotificationService().sendNotificationsBasedOnPreferences();
    return Future.value(true);
  });
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<DbCubit>(create: (context) => DbCubit()),
        BlocProvider<NotificationCubit>(
            create: (context) => NotificationCubit()),
        BlocProvider<LocationCubit>(create: (context) => LocationCubit()),
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
