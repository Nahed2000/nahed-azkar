import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_cache_manager/media_cache_manager.dart';
import 'package:nahed_azkar/database/db_controller.dart';
import 'package:nahed_azkar/pref/pref_controller.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
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

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter_background_service/flutter_background_service.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     // إعداد الإشعارات المحلية
//     _initializeNotifications();
//     // إطلاق الإشعار عند فتح التطبيق
//     scheduleRandomNotification();
//     // بدء الخدمة الخلفية عند بدء الصفحة
//     startBackgroundService();
//   }
//
//   // إعداد الإشعارات المحلية
//   void _initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const InitializationSettings initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid);
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   // قائمة البيانات
//   final List<String> data = ['asd', 'we', 'er'];
//
//   // دالة لإرسال الإشعار
//   Future<void> scheduleRandomNotification() async {
//     final random = Random();
//     final randomIndex = random.nextInt(data.length);
//     final notificationText = data[randomIndex];
//
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       channelDescription: 'your_channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     final now = DateTime.now().toUtc();
//     final  scheduledTime = now.add(const Duration(hours: 1));
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'عنوان الإشعار',
//       notificationText,
//       scheduledTime,
//       platformChannelSpecifics,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
//
//   // بدء الخدمة الخلفية
//   void startBackgroundService() {
//     WidgetsFlutterBinding.ensureInitialized();
//     FlutterBackgroundService.initialize(onStart);
//
//     FlutterBackgroundService().start();
//   }
//
//   // دالة البدء
//   void onStart() {
//     Timer.periodic(const Duration(hours: 1), (timer) {
//       scheduleRandomNotification();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scheduled Notifications'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // بدء الخدمة الخلفية عند الضغط على الزر
//             startBackgroundService();
//           },
//           child: const Text('بدء الإشعارات المجدولة'),
//         ),
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'package:nahed_azkar/services/notification.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final NotificationService notificationService = NotificationService();
//   await notificationService.initialize();
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // عرض الإشعار عند فتح التطبيق
//     NotificationService().showNotification();
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('MyApp'),
//         ),
//         body: const Center(
//           child: Text('Welcome to MyApp'),
//         ),
//       ),
//     );
//   }
// }
//
//
