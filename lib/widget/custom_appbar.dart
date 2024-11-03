import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/home_cubit/home_cubit.dart';
import '../cubit/home_cubit/home_state.dart';
import '../cubit/location_cubit/location_cubit.dart';
import '../screen/app/quran/reciters/reciters_sura.dart';
import '../screen/app/quran/search_quran.dart';
import '../services/constant.dart';

mixin CustomsAppBar {
  AppBar customAppBar({
    required BuildContext context,
    required String title,
    bool changeText = false,
    bool isQuran = false,
  }) {
    return AppBar(
      backgroundColor: MyConstant.primaryColor,
      toolbarHeight: 100.h,
      elevation: 0,
      iconTheme: IconThemeData(color: MyConstant.myWhite),
      leading: changeText
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios))
          : null,
      actions: [
        changeText
            ? IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.w),
                        topRight: Radius.circular(50.w),
                      ),
                    ),
                    builder: (context) => BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return Container(
                          color: MyConstant.myWhite,
                          alignment: Alignment.center,
                          height: 150.h,
                          width: 150.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('تغير حجم الخط',
                                  style: TextStyle(
                                    color: MyConstant.primaryColor,
                                    fontSize: 18.sp,
                                  )),
                              Slider(
                                activeColor: MyConstant.primaryColor,
                                inactiveColor: Colors.grey,
                                onChanged: (value) {
                                  BlocProvider.of<HomeCubit>(context)
                                      .changeTextSize(value);
                                },
                                value: BlocProvider.of<HomeCubit>(context)
                                    .sizeText,
                                min: 18,
                                max: 38,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    context: context,
                  );
                },
                icon: const Icon(Icons.text_fields))
            : const SizedBox(),
        isQuran
            ? Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchQuran(),
                            ),
                          ),
                      icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RecitersSura(),
                            ),
                          ),
                      icon: const Icon(Icons.volume_up_outlined)),
                ],
              )
            : const SizedBox(),
        SizedBox(width: 10.w),
      ],
      centerTitle: true,
      title: Text(title,
          style: TextStyle(fontSize: 18.sp, color: MyConstant.myWhite)),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: MyConstant.primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.h),
          bottomRight: Radius.circular(50.h),
        ),
      ),
    );
  }

  AppBar appBarPrayTime(
      {required String title, required BuildContext context}) {
    return AppBar(
      backgroundColor: MyConstant.primaryColor,
      toolbarHeight: 100.h,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: Text(title,
          style: TextStyle(fontSize: 26.sp, color: MyConstant.myWhite)),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: MyConstant.primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.h),
          bottomRight: Radius.circular(50.h),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () =>
              BlocProvider.of<LocationCubit>(context).getPosition(context),
          icon: const Icon(Icons.refresh, size: 28),
        )
      ],
    );
  }

  AppBar settingsAppBar(
      {required String title, required BuildContext context}) {
    return AppBar(
      centerTitle: true,
      backgroundColor: MyConstant.primaryColor,
      toolbarHeight: 100.h,
      title: Text(
        title,
        style: TextStyle(fontSize: 18.sp, color: MyConstant.myWhite),
      ),
      elevation: 0,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios)),
      iconTheme: IconThemeData(color: MyConstant.myWhite),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: MyConstant.primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.h),
          bottomRight: Radius.circular(50.h),
        ),
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
        backgroundColor: MyConstant.primaryColor,
        iconTheme: IconThemeData(color: MyConstant.myWhite),
        elevation: 0,
        centerTitle: true,
        title: Text('لِّيَطْمَئِنَّ قَلْبِي',
            style: TextStyle(fontSize: 24, color: MyConstant.myWhite)),
        toolbarHeight: 70);
  }
}
