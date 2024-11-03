import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/notification_cubit/notification_state.dart';
import 'package:nahed_azkar/storage/pref_controller.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';

import '../cubit/notification_cubit/notification_cubit.dart';
import '../widget/settings/notification_item.dart';

class NotificationScreen extends StatelessWidget with Helpers, CustomsAppBar {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<NotificationCubit>(context);
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: settingsAppBar(context: context, title: 'الإشعارات'),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(20.w),
            children: [
              NotificationItems(
                title: 'الإشعارات',
                onPress: (value) async {
                  cubit.changeAllNotification(value);
                },
                subtitle: "التحكم بالإشعارات بشكل كامل",
                value: SharedPrefController().allNotificationItem,
              ),
              SizedBox(height: 13.h),
              NotificationItems(
                title: 'التذكير التلقائي',
                onPress: (value) {
                  cubit.hourlyNotification(value);
                },
                subtitle: "التحكم بإشعارات التذكير التلقائي",
                value: SharedPrefController().hourlyNotificationItem,
              ),
              SizedBox(height: 13.h),
              NotificationItems(
                title: 'الصلاة على النبي',
                onPress: (value) {
                  cubit.prayOfMohammedNotification(value);
                },
                subtitle: "التحكم بإشعارات الصلاة على النبي",
                value: SharedPrefController().prayOfMohammedNotification,
              ),
              SizedBox(height: 13.h),
              NotificationItems(
                title: 'الورد اليومي من القرآن',
                onPress: (value) {
                  cubit.quranNotification(value);
                },
                subtitle: "التحكم بإشعارات الورد اليومي من القرآن",
                value: SharedPrefController().quranNotificationItem,
              ),
              SizedBox(height: 13.h),
              NotificationItems(
                title: ' تذكير في سورة الكهف',
                onPress: (value) {
                  cubit.alkahefNotification(value);
                },
                subtitle: "التحكم بإشعارات سورة الكهف",
                value: SharedPrefController().alkahefNotificationItem,
              ),
              SizedBox(height: 13.h),
              NotificationItems(
                title: 'أذكار الصباح',
                onPress: (value) {
                  cubit.morningNotification(value);
                },
                subtitle: "التحكم بإشعارات أذكار الصباح",
                value: SharedPrefController().morningNotificationItem,
              ),
              SizedBox(height: 13.h),
              NotificationItems(
                title: 'أذكار المساء',
                onPress: (value) {
                  cubit.eveningNotification(value);
                },
                subtitle: "التحكم بإشعارات أذكار المساء",
                value: SharedPrefController().eveningNotificationItem,
              ),
            ],
          );
        },
      ),
    );
  }
}
//request
