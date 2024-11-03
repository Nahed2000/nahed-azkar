import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../cubit/home_cubit/home_cubit.dart';
import '../../../cubit/home_cubit/home_state.dart';
import '../../../services/constant.dart';

class QuranList extends StatelessWidget {
  const QuranList(this.currentIndex, {Key? key}) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    int numberOfSura = quran.getVerseCount(currentIndex);
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: AppBar(
        clipBehavior: Clip.antiAlias,
        centerTitle: true,
        toolbarHeight: 100.h,
        backgroundColor: MyConstant.primaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        title: Text(
          quran.getSurahNameArabic(currentIndex),
          style: TextStyle(color: MyConstant.myWhite),
        ),
        iconTheme: IconThemeData(color: MyConstant.myWhite),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(
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
                              value:
                                  BlocProvider.of<HomeCubit>(context).sizeText,
                              min: 17,
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
              icon: const Icon(Icons.text_fields)),
          SizedBox(width: 20.w),
        ],
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 13),
          children: [
            currentIndex == 1 || currentIndex == 9
                ? const SizedBox()
                : Text(quran.basmala,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyConstant.primaryColor, fontSize: 30.sp)),
            SizedBox(height: 10.h),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: List.generate(
                      numberOfSura,
                      (index) => TextSpan(
                        text: quran.getVerse(currentIndex, index + 1,
                            verseEndSymbol: true),
                        style: GoogleFonts.amiri(
                          color: MyConstant.primaryColor,
                          fontSize:
                              BlocProvider.of<HomeCubit>(context).sizeText,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
