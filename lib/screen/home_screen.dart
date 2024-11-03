import 'package:adhan/adhan.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/location_cubit/location_cubit.dart';
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
    NotificationService().sendNotificationsBasedOnPreferences();
    NotificationService().requestAlarmPermission();
    NotificationService().sendImmediateNotification(
      title: "ليطمئن قلبي",
      body: "لا تنسى قراءة أذكارك اليوم!",
    );
    // TODO: implement initState
    if (SharedPrefController().longitude != null &&
        SharedPrefController().longitude != null) {
      BlocProvider.of<LocationCubit>(context).changeMyCoordinates(
          Coordinates(
            SharedPrefController().latitude!,
            SharedPrefController().longitude!,
          ),
          context);
    } else {
      BlocProvider.of<LocationCubit>(context).getPosition(context);
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
            backgroundColor: MyConstant.myWhite,
            drawer: cubit.currentIndex == 0 ? DrawerScreen() : null,
            appBar: cubit.currentIndex != 0
                ? (cubit.currentIndex == 1
                    ? appBarPrayTime(
                        context: context,
                        title: cubit.listScreen[cubit.currentIndex].title)
                    : customAppBar(
                        context: context,
                        title: cubit.listScreen[cubit.currentIndex].title,
                        isQuran: cubit.currentIndex == 2))
                : homeAppBar(),
            body: cubit.listScreen[cubit.currentIndex].body,
            bottomNavigationBar: CurvedNavigationBar(
              height: 50.h,
              buttonBackgroundColor: MyConstant.myWhite,
              onTap: (value) => cubit.changeCurrentIndex(value),
              index: cubit.currentIndex,
              backgroundColor: MyConstant.primaryColor,
              color: MyConstant.myWhite,
              items: [
                Icon(FlutterIslamicIcons.mosque, color: MyConstant.myGrey),
                Icon(FlutterIslamicIcons.sajadah,
                    weight: 38.w, color: MyConstant.myGrey),
                Icon(FlutterIslamicIcons.quran2, color: MyConstant.myGrey),
                Icon(FlutterIslamicIcons.kaaba, color: MyConstant.myGrey),
                Icon(MyConstant.cogOutline, color: MyConstant.myGrey)
              ],
            ));
      },
    );
  }
}
