import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screen/app/quran/reciters/reciters_sura.dart';
import '../screen/app/quran/search_quran.dart';
import '../services/constant.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

AppBar customAppBar(
  BuildContext context,
  String title, {
  bool bnbar = true,
  bool changeText = false,
  bool isQuran = false,
}) {
  return AppBar(
      backgroundColor: MyConstant.primaryColor,
      toolbarHeight: 100.h,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        changeText
            ? IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.w),
                            topRight: Radius.circular(50.w))),
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
      leading: bnbar
          ? null
          : IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
      centerTitle: true,
      title: Text(title,
          style:
              TextStyle(fontSize: bnbar ? 26.sp : 18.sp, color: Colors.white)),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: MyConstant.primaryColor),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(25.h)));
}
