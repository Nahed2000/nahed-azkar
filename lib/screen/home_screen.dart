import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/services/notification.dart';

import '../services/constant.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'dart:math';

import '../data/azkar.dart';
import '../widget/app/copy_button.dart';
import '../widget/app/share_button.dart';
import '../widget/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    NotificationService().sendNotification();
    // TODO: implement initState
    BlocProvider.of<HomeCubit>(context).getPosition();
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
            appBar: cubit.currentIndex != 0
                ? customAppBar(
                    context, cubit.listScreen[cubit.currentIndex].title,
                    isQuran: cubit.currentIndex == 2)
                : null,
            body: cubit.listScreen[cubit.currentIndex].body,
            bottomNavigationBar: CurvedNavigationBar(
              height: 50.h,
              buttonBackgroundColor: MyConstant.myWhite,
              onTap: (value) => cubit.changeCurrentIndex(value),
              index: cubit.currentIndex,
              backgroundColor: MyConstant.primaryColor,
              color: MyConstant.myWhite,
              // buttonBackgroundColor: MyConstant.myWhite,
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

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        int randomIndex = Random().nextInt(DataOfAzkar.randomZikr.length);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.w),
          ),
          title: const Text('فذكر'),
          content: Text(DataOfAzkar.randomZikr[randomIndex][0]),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShareButton(text: DataOfAzkar.randomZikr[randomIndex][0]),
                CopyButton(
                    textCopy: DataOfAzkar.randomZikr[randomIndex][0],
                    textMessage: 'تم نسخ الذكر'),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyConstant.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.h))),
                  child: Text(
                    'تم',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: MyConstant.myWhite,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
