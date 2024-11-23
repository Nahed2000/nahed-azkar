import 'package:adhan/adhan.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/location_cubit/prayer_time_cubit.dart';
import 'package:nahed_azkar/screen/home/quran/sura_list.dart';
import 'package:nahed_azkar/services/notification.dart';
import 'package:nahed_azkar/storage/pref_controller.dart';
import 'package:nahed_azkar/utils/helpers.dart';

import '../cubit/home_cubit/home_state.dart';
import '../services/constant.dart';
import '../cubit/home_cubit/home_cubit.dart';
import '../widget/custom_appbar.dart';
import 'drawer/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with CustomsAppBar, Helpers {
  @override
  void initState() {
    NotificationService().requestAlarmPermission();
    // NotificationService().sendAllNotificationsBasedOnPreferences();
    // NotificationService().sendNowNotification(
    //   title: "ليطمئن قلبي",
    //   body: "لا تنسى قراءة أذكارك اليوم!",
    // );
    if (SharedPrefController().longitude != null &&
        SharedPrefController().longitude != null) {
      BlocProvider.of<PrayerTimeCubit>(context).changeMyCoordinates(
          Coordinates(
            SharedPrefController().latitude!,
            SharedPrefController().longitude!,
          ),
          context);
    } else {
      BlocProvider.of<PrayerTimeCubit>(context).getPosition(context);
    }
    WidgetsBinding.instance
        .addPostFrameCallback((_) => showAlertDialog(context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: MyConstant.kWhite,
            drawer: DrawerScreen(),
            appBar: cubit.currentIndex != 0
                ? customAppBar(
                    context: context,
                    title: cubit.listScreen[cubit.currentIndex].title,
                    isPrayTime: cubit.currentIndex == 1)
                : homeAppBar(),
            body: cubit.listScreen[cubit.currentIndex].body,
            floatingActionButton: Visibility(
              visible: cubit.currentIndex == 2,
              child: FloatingActionButton(
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuraList(
                        currentIndex: SharedPrefController().suraNumber,
                      ),
                    ),
                  );
                },
                elevation: 4,
                backgroundColor: MyConstant.kPrimary,
                child: const Icon(Icons.bookmark_outline, color: Colors.white),
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              height: 50.h,
              buttonBackgroundColor: MyConstant.kWhite,
              onTap: (value) => cubit.changeCurrentIndex(value),
              index: cubit.currentIndex,
              backgroundColor: MyConstant.kPrimary,
              color: MyConstant.kWhite,
              items: [
                Icon(FlutterIslamicIcons.mosque, color: MyConstant.kGrey),
                Icon(FlutterIslamicIcons.sajadah,
                    weight: 38.w, color: MyConstant.kGrey),
                Icon(FlutterIslamicIcons.quran2, color: MyConstant.kGrey),
                Icon(FlutterIslamicIcons.kaaba, color: MyConstant.kGrey),
                Icon(MyConstant.cogOutline, color: MyConstant.kGrey)
              ],
            ));
      },
    );
  }
}
